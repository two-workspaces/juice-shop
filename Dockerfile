# Upstream's official image, pinned. It honours $PORT, keeps no data between
# restarts (the SQLite shop is rebuilt on every boot, by design) and is distroless,
# so there is no shell: everything Railway needs is done with COPY.
FROM bkimminich/juice-shop:v20.4.0

# Lets template variables reach the config (base URL, chatbot LLM, safety mode).
COPY --chown=65532:0 custom-environment-variables.yml /juice-shop/config/custom-environment-variables.yml

# Railway containers have no /.dockerenv, so Juice Shop's safety mode would not see a
# container and would turn on the challenges it disables under Docker (RCE/XXE DoS,
# memory bomb, SSTi...), which can hang or crash the service. With the marker file it
# behaves exactly like `docker run bkimminich/juice-shop`. SAFETY_MODE=disabled (or the
# ctf profile) turns them back on.
COPY dockerenv /.dockerenv
