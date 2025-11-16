# SPDX-License-Identifier: Apache-2.0 OR MIT

FROM quay.io/podman/stable:latest

RUN dnf install -y rpm-ostree && dnf clean all

COPY --chmod=755 with-storage.sh /with-storage.sh
