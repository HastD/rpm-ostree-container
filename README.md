This container image is designed to allow running
[rpm-ostree](https://github.com/coreos/rpm-ostree/) on systems where it's not
available as a package.

As a convenience, the container has an entrypoint that looks for an initial
`--storage` argument, and if provided, uses it to set the podman container
storage directory, executing the remaining arguments as a command. When the
host's container storage is mounted in the container, this allows performing
container operations (e.g. with `rpm-ostree`) on the host.

For example:

```sh
storage_dir="$HOME/.local/share/containers/storage"
podman run --privileged --rm -v "${storage_dir}:${storage_dir}" \
    rpm-ostree-container:latest --storage="${storage_dir}" \
    rpm-ostree compose build-chunked-oci [...]
```
