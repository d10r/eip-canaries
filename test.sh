#!/usr/bin/env sh

EIP_3855_EXPECTED=false \
EIP_1153_EXPECTED=false \
forge test --evm-version paris

EIP_3855_EXPECTED=true \
EIP_1153_EXPECTED=false \
forge test --evm-version shanghai

EIP_3855_EXPECTED=true \
EIP_1153_EXPECTED=true \
forge test --evm-version cancun
