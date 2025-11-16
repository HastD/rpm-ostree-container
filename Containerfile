# SPDX-License-Identifier: Apache-2.0 OR MIT

FROM quay.io/podman/stable:latest

RUN dnf install -y rpm-ostree && dnf clean all

COPY --chmod=755 rpm-ostree-run.sh /rpm-ostree-run.sh
