# papermc_role

An Ansible role to create a PaperMC Minecraft server.

## Requirements

* Ansible version 2.17.5 or higher
* Almalinux 9.4 host

## Usage

### Installation
```
ansible-galaxy role install apigban.papermc_role
```

## Role Variables

The following variables can be configured for this role. See `defaults/main.yml` for default values.

### User Configuration

* `user.home_dir`: The home directory for the Minecraft server user (default: `/home/ansible`).
* `user.name`: The name of the Minecraft server user (default: `ansible`).

### Tailscale Configuration

* `tailscale.enabled`: Enable or disable Tailscale integration (default: `true`).
* `tailscale.authkey`: The Tailscale authentication key.

### Domain Joining Configuration

* `join_domain.enabled`: Enable or disable domain joining (default: `false`).

### Package Management

* `packages`: A list of packages to install (default: `['java-21-openjdk', 'tmux']`).

### Firewall Configuration

* `firewall_ports`: A list of firewall ports to open (default: `['19132/udp', '19132/tcp', '25565/udp', '25565/tcp']`).

### PaperMC Configuration

* `papermc_server_jar_path`: The path to the PaperMC server JAR file (default: `/usr/local/bin/papermc-server.jar`).
* `paperMC_gamemode`: The default game mode for the server (default: `survival`, allowed values: `"survival"`, `"creative"`).
* `paperMC_version`: The PaperMC version to download (default: `1.21.3`).
* `paperMC_build`: The PaperMC build number to download (default: `81`).
* `paperMC_eula`: Whether to accept the PaperMC EULA (default: `true`).
* `paperMC_url`: The URL to download the PaperMC JAR file.
* `paperMC_plugins_path`: The directory where PaperMC plugins will be installed (default: `/home/ansible/papermc/plugins`).
* `paperMC_plugins`: A dictionary of PaperMC plugins to install, including their download URL and configuration path.

### Template Sources

* `eula_template_src`: The source template for the EULA file (default: `templates/eula.txt.j2`).
* `server_properties_template_src`: The source template for the `server.properties` file (default: `templates/server.properties.j2`).

### Cron Job

* `papermc_cron_job`: The cron job command to start the PaperMC server on reboot.
* `reboot_message`: The message to display when rebooting the server.

### Variable Files

* `papermc_dir`: The main PaperMC directory (defined in `vars/main.yml` as `/home/ansible/papermc`).

## Tasks

This role performs the following main tasks:

* Creates a dedicated user for the PaperMC server.
* Sets the hostname of the server.
* Installs required packages (Java, tmux).
* Configures the firewall to allow traffic on necessary ports.
* Creates the PaperMC server directory.
* Downloads the specified PaperMC server JAR.
* Copies the PaperMC JAR to `/usr/local/bin/`.
* Copies the `papermc-start.sh` script.
* Accepts the PaperMC EULA.
* Installs and configures plugins defined in `defaults/main.yml`.
* Configures the `server.properties` file using a template.
* Creates a cron job to start the server on reboot.
* Optionally reboots the server to apply changes.

## Example Playbook

```yaml
- hosts: servers
  roles:
    - role: papermc_role
      # Example variable overrides
      # user:
      #   name: "minecraft"
      #   home_dir: "/opt/minecraft"
      # paperMC_gamemode: "creative"
```

## Testing

This role uses Molecule for testing. To run the tests:

1. Ensure you have Molecule installed.
2. Navigate to the `molecule/default/` directory.
3. Run `molecule test`.

The following files are used for testing:

* `converge.yml`:  Used to bring the system to the desired state.
* `molecule.yml`: Contains the Molecule configuration for the test environment.
* `requirements.yml`: Lists any dependencies for the Molecule scenario.
* `verify.yml`: Contains assertions to verify the role's functionality.

## License

MIT

## Author Information

This role was created in December 2024 by [Alain Igban](https://alain.apigban.com)