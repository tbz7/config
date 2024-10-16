test -d ~/.local/state/nix/profile || exit

set -Ux NIX_PROFILES ~/.local/state/nix/profile

fish_add_path -g {$NIX_PROFILES}/bin

if [ -f /etc/ssl/certs/ca-certificates.crt ]
    set -gx NIX_SSL_CERT_FILE /etc/ssl/certs/ca-certificates.crt
else if [ -f /etc/ssl/cert.pem ]
    set -gx NIX_SSL_CERT_FILE /etc/ssl/cert.pem
end

if [ -f /usr/lib/locale/locale-archive ]
    set -gx LOCALE_ARCHIVE /usr/lib/locale/locale-archive
end

if [ (uname) = Darwin ]
    ulimit -n 10240
end
