# 🦀 ClawCore Linux

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![OS Architecture](https://img.shields.io/badge/Architecture-x86__64%20%7C%20ARM64-blue.svg)](#)
[![Footprint](https://img.shields.io/badge/ISO%20Size-~1.3%20GB-brightgreen.svg)](#)

**ClawCore Linux** is an ultra-lightweight, ephemeral, and autonomous AI-agent operating system. By fusing the micro-architecture of **Tiny Core Linux** with the lean, 5-file codebase of **NanoClaw**, ClawCore boots entirely into your system memory (RAM). It converts any old hardware, laptop, or server into a completely air-gapped, power-saving, local AI workstation without touching your hard drive.

---

## 🚀 Key Features

* **Zero-Disk Footprint:** Boots 100% into RAM. Once you pull the USB drive or power down, your host system leaves absolutely zero forensic trace.
* **Maximized Energy Efficiency:** Spin-down hard drives and lower your clock cycles. ClawCore runs only the bare essentials—eliminating background telemetry, UI bloating, and heavy cloud synchronization overhead.
* **Sandboxed Bash Execution:** NanoClaw acts as an integrated system agent, executing self-directed bash scripts safely inside an isolated environment.
* **Air-Gapped & Secure:** Works entirely offline. Your files, documents, and prompts are processed locally through embedded quantized Large Language Models.

---

## 📐 System Blueprint & Size Breakdown

| Component | Target Size | Purpose |
| :--- | :--- | :--- |
| **ClawCore Base (Tiny Core)** | ~22 MB | Super-stripped Linux kernel and basic BusyBox runtime utilities. |
| **Runtimes & Tools** | ~70 MB | Node.js engine, standard C libraries (`musl`), and micro-SQL databases. |
| **NanoClaw Orchestrator** | ~2 MB | The ultra-lean core logic, system tools, and custom Markdown skills. |
| **Quantized Local LLM** | ~1.2 GB | A default highly-optimized 4-bit quantized model (e.g., *Qwen2.5-3B-Instruct* or *Llama-3-8B-Instruct*). |
| **Total System Footprint** | **~1.3 GB** | **Easily fits onto any standard, low-cost 2GB USB flash drive.** |

---

## 🛠️ Instant Setup & One-Click Build

You can compile your own custom `clawcore_live.iso` file using any Linux environment or Windows Subsystem for Linux (WSL2).

### Step 1: Run the Automated Build Script
Clone this repository and execute the bootstrap script. It automatically pulls down the micro-kernel framework, compiles node environments, attaches NanoClaw, fetches your LLM, and builds the bootable media.

```bash
git clone https://github.com/jason-sia/clawcore-linux.git
cd clawcore-linux
chmod +x build_iso.sh
./build_iso.sh
