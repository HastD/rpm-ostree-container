This container image is designed to allow running
[rpm-ostree](https://github.com/coreos/rpm-ostree/) on systems where it's not
available as a package.

As a convenience, the container has a script at `/rpm-ostree-run.sh` that sets
the first argument passed to it as the podman container storage directory, and
passes the remaining arguments to `rpm-ostree`. When the host's container
storage is mounted in the container, this allows `rpm-ostree` to perform
container operations on the host.

For example:

```sh
storage_dir="$HOME/.local/share/containers/storage"
podman run --privileged --rm -it \
    -v "${storage_dir}:${storage_dir}" \
    rpm-ostree-container:latest \
    /rpm-ostree-run.sh "${storage_dir}" compose build-chunked-oci [...]
```
