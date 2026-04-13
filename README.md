# nixos-config
My personal NixOS configurations managed via **Flakes**.

---

## ⚠️ Important: Hardware Configuration

This repository does not include a universal `hardware-configuration.nix`. NixOS configurations are highly dependent on your specific hardware, disk partitions, and file systems. You **must** generate a configuration specific to your machine before proceeding.

### 1. Generate your hardware config
If you are currently on the NixOS installation media, run:
```shell
nixos-generate-config --show-hardware-config > hardware-configuration.nix
```

### 2. Why this is necessary
Nix Flakes can only access files that are tracked by Git. Since your `hardware-configuration.nix` is unique to your machine and usually ignored by this repository, you must manually stage it so the installer can "see" it.

---

## 🚀 Installing

Run these commands from the root of this repository to install the `bertor` configuration:

```shell
# 1. Temporarily force-add the hardware config to the git index
git add -f hardware-configuration.nix

# 2. Install the configuration
nixos-install --flake ./#bertor

# 3. Remove the hardware config from the index to keep the repo clean
git rm --cache hardware-configuration.nix
```

---

## 🛠 Post-Installation
Once the system is installed and you have booted into it, you can apply future changes by running:
```shell
sudo nixos-rebuild switch --flake .
```

> **Note:** If you intend to manage this machine permanently with this repo, consider moving the `hardware-configuration.nix` to a dedicated host folder (e.g., `./hosts/bertor/`) and committing it to your branch.
