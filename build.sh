#!/bin/sh
rustup default nightly
cargo install cross
export PATH=~/.cargo/bin:$PATH
version=`cat geph4Version`
git clone --depth 1 --branch "$version" https://github.com/geph-official/geph4
cd geph4

sh osx_build.sh

cross build --release --locked --target i686-pc-windows-gnu --manifest-path=geph4-client/Cargo.toml
cross build --release --locked --target x86_64-unknown-linux-musl --manifest-path=geph4-client/Cargo.toml
cross build --release --locked --target x86_64-unknown-linux-gnu --manifest-path=geph4-vpn-helper/Cargo.toml
cross build --release --locked --target armv7-linux-androideabi --manifest-path=geph4-client/Cargo.toml
cross build --release --locked --target aarch64-linux-android --manifest-path=geph4-client/Cargo.toml
cross build --release --locked --target armv7-unknown-linux-musleabihf --manifest-path=geph4-client/Cargo.toml
cross build --release --locked --target aarch64-unknown-linux-musl --manifest-path=geph4-client/Cargo.toml
cross build --release --locked --target aarch64-unknown-linux-musl --manifest-path=geph4-vpn-helper/Cargo.toml

mkdir OUTPUT
mv target/x86_64-unknown-linux-musl/release/geph4-client OUTPUT/geph4-client-linux-amd64
mv target/x86_64-unknown-linux-gnu/release/geph4-vpn-helper OUTPUT/geph4-vpn-helper-linux-amd64
mv target/armv7-unknown-linux-musleabihf/release/geph4-client OUTPUT/geph4-client-linux-armv7
mv target/armv7-linux-androideabi/release/geph4-client OUTPUT/geph4-client-android-armv7
mv target/aarch64-linux-android/release/geph4-client OUTPUT/geph4-client-android-aarch64
mv target/i686-pc-windows-gnu/release/geph4-client.exe OUTPUT/geph4-client-windows-i386.exe
mv target/x86_64-apple-darwin/release/geph4-client OUTPUT/geph4-client-macos-amd64
mv target/aarch64-unknown-linux-musl/release/geph4-client OUTPUT/geph4-client-linux-aarch64
mv target/aarch64-unknown-linux-musl/release/geph4-vpn-helper OUTPUT/geph4-vpn-helper-linux-aarch64

exit 0
