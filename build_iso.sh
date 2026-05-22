#!/bin/bash
# One-Click Build Script for the Custom NanoClaw Tiny Core ISO

echo "🚀 Bootstrapping custom AI OS..."
mkdir -p custom_iso/tce/optional

# 1. Download Tiny Core Linux base
wget http://tinycorelinux.net/14.x/x86_64/release/CorePure64-current.iso -O base.iso

# 2. Fetch required extensions (Node.js, SQLite, SquashFS tools)
cd custom_iso/tce/optional
wget http://tinycorelinux.net/14.x/x86_64/tcz/node.tcz
wget http://tinycorelinux.net/14.x/x86_64/tcz/sqlite3.tcz
echo "node.tcz\nsqlite3.tcz" > ../onboot.lst
cd ../..

# 3. Clone and inject NanoClaw
# git clone https://github.com/nanocoai/nanoclaw.git custom_iso/nanoclaw
# cd custom_iso/nanoclaw && npm install --production && cd ../..
# 3. Clone and inject NanoClaw (Safe overwrite + Ignore development hooks)
if [ -d "custom_iso/nanoclaw" ]; then
    echo "⚠️ Target directory exists. Cleaning up older clone..."
    rm -rf custom_iso/nanoclaw
fi

git clone https://github.com/nanocoai/nanoclaw.git custom_iso/nanoclaw
cd custom_iso/nanoclaw

# --ignore-scripts forces npm to bypass development tools like Husky during a production build
npm install --production --ignore-scripts

cd ../..


# 4. Download ultra-lightweight Local LLM (Example: Qwen 3B quantized)
mkdir -p custom_iso/models
wget -O custom_iso/models/model.gguf https://huggingface.co/Qwen/Qwen2.5-3B-Instruct-GGUF/resolve/main/qwen2.5-3b-instruct-q4_k_m.gguf

# 5. Set NanoClaw to launch automatically on boot
mkdir -p custom_iso/etc/init.d
cat << 'EOF' > custom_iso/etc/init.d/start_nanoclaw
#!/bin/sh
cd /nanoclaw
node dist/index.js --model /models/model.gguf &
EOF
chmod +x custom_iso/etc/init.d/start_nanoclaw

# 6. Package everything back into a bootable "One-Click" ISO
mkisofs -R -V "AI_OS" -b boot/isolinux/isolinux.bin -c boot/isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -o clawcore_live.iso custom_iso/

echo "✅ Done! Flash 'clawcore_live.iso' to a USB stick and boot directly into your AI assistant."
