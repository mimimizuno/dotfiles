#!/bin/sh
# 社内ネットワーク(Zscaler/Credit SAISON Enterprise CA)の証明書がJavaの
# 標準証明書ストアに入っていないため、GradleがMaven Central等からの
# ダウンロード時にSSLエラーになる。Jamfが配布するCAバンドルを取り込んだ
# 専用のトラストストアを ~/.gradle/corporate-truststore.jks に作成する。
#
# CAバンドル自体は各マシンにJamf経由で配布されるため、生成物
# (corporate-truststore.jks)はリポジトリにコミットせず、このスクリプトで
# 都度生成する。

set -eu

CA_BUNDLE="$HOME/.ca-certificates/jamf-managed_ca_bundle.pem"
TRUSTSTORE="$HOME/.gradle/corporate-truststore.jks"

if [ ! -f "$CA_BUNDLE" ]; then
    echo "CAバンドルが見つかりません: $CA_BUNDLE (このマシンでは不要かもしれません)"
    exit 0
fi

java_home_21=$(/usr/libexec/java_home -v 21 2>/dev/null) || {
    echo "Java 21が見つかりません。先にインストールしてください。"
    exit 1
}

mkdir -p "$HOME/.gradle"
cp "$java_home_21/lib/security/cacerts" "$TRUSTSTORE"
chmod 600 "$TRUSTSTORE"

tmp_dir=$(mktemp -d)
awk '/-----BEGIN CERTIFICATE-----/{n++} {print > ("'"$tmp_dir"'/cert-" n ".pem")}' "$CA_BUNDLE"

for cert in "$tmp_dir"/cert-*.pem; do
    alias="corp-$(basename "$cert" .pem)"
    "$java_home_21/bin/keytool" -importcert -noprompt -trustcacerts \
        -keystore "$TRUSTSTORE" -storepass changeit \
        -alias "$alias" -file "$cert"
done

echo "トラストストアを作成しました: $TRUSTSTORE"
