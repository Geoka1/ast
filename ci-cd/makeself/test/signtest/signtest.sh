#!/usr/bin/env bash
set -eu
THIS="$(readlink -f "$0")"
THISDIR="$(dirname "${THIS}")"
SUT="$(dirname "$(dirname "${THISDIR}")")/makeself.sh"
LOGFILE="${THISDIR}/test_results.log"

echo "Test results:" > "${LOGFILE}"

log_result() {
    local test_name="$1"
    local result="$2"
    local details="${3:-}"
    echo "${result}: ${test_name} ${details}" >> "${LOGFILE}"
}

# $1 : keyid
cat_key() {
    case "$1" in
        3DD6797A5EDE9A253311C13AED3E040B19F6996E)
            cat <<'EOF'
-----BEGIN PGP PRIVATE KEY BLOCK-----

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
F/K8LdM3iHJ5iWSRmORhAM4oXxZbV6v73Qm+Aw0=
=ePfs
-----END PGP PRIVATE KEY BLOCK-----
EOF
            ;;
        3F717988DF7D8D55A1660FC1A5ECF255B5AE77E1)
            cat <<'EOF'
-----BEGIN PGP PRIVATE KEY BLOCK-----

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
PQl0YDACFfPjOrJmtqQctIB61Bzgem8OVT90j9s=
=Lm2k
-----END PGP PRIVATE KEY BLOCK-----
EOF
            ;;
        *)
            cat </dev/null
            ;;
    esac
}

# $1 : keyid
checked_import_key() {
    cat_key "$1" | gpg --quiet --import --passphrase=password123 --pinentry-mode=loopback --trust-model=always
    gpg --list-secret-keys "$1" >/dev/null 2>&1
    return $?
}

# $1 : keyid
# rest : makeself options
create_sign_verify() {
    local keyid="$1"
    shift
    local archive_dir
    archive_dir="$(mktemp -dt archive_dir.XXXXXX)"
    touch "${archive_dir}/foo.txt" "${archive_dir}/bar.txt" "${archive_dir}/qux.txt"

    local archive_run="${archive_dir}.run"
    local output="${archive_run}.out"

    if "$SUT" --sign password123 "$@" "${archive_dir}" "${archive_run}" "signtest" ls >"${output}"; then
        grep -Exq 'Signature: [[:alnum:]+/]+' "${output}" || return 1
        eval "${archive_run}" --verify-sig "${keyid}" || return 1
    else
        return 1
    fi

    rm -rf "${archive_dir}" "${archive_run}" "${output}"
}

testSingleKey() {
    local GNUPGHOME
    GNUPGHOME="$(mktemp -dt GNUPGHOME.XXXXXX)"
    export GNUPGHOME

    if checked_import_key 3DD6797A5EDE9A253311C13AED3E040B19F6996E; then
        if create_sign_verify 3DD6797A5EDE9A253311C13AED3E040B19F6996E; then
            log_result "testSingleKey" "PASS"
        else
            log_result "testSingleKey" "FAIL" "Failed to sign/verify archive with single key"
        fi
    else
        log_result "testSingleKey" "FAIL" "Failed to import single key"
    fi

    rm -rf "${GNUPGHOME}"
}

testMultipleKeys() {
    local GNUPGHOME
    GNUPGHOME="$(mktemp -dt GNUPGHOME.XXXXXX)"
    export GNUPGHOME

    if checked_import_key 3DD6797A5EDE9A253311C13AED3E040B19F6996E && checked_import_key 3F717988DF7D8D55A1660FC1A5ECF255B5AE77E1; then
        if create_sign_verify 3DD6797A5EDE9A253311C13AED3E040B19F6996E --gpg-extra "--local-user=3DD6797A5EDE9A253311C13AED3E040B19F6996E"; then
            log_result "testMultipleKeys (Key 1)" "PASS"
        else
            log_result "testMultipleKeys (Key 1)" "FAIL"
        fi

        if create_sign_verify 3F717988DF7D8D55A1660FC1A5ECF255B5AE77E1 --gpg-extra "--local-user=3F717988DF7D8D55A1660FC1A5ECF255B5AE77E1"; then
            log_result "testMultipleKeys (Key 2)" "PASS"
        else
            log_result "testMultipleKeys (Key 2)" "FAIL"
        fi
    else
        log_result "testMultipleKeys" "FAIL" "Failed to import keys"
    fi

    rm -rf "${GNUPGHOME}"
}

testWrongKey() {
    local GNUPGHOME
    GNUPGHOME="$(mktemp -dt GNUPGHOME.XXXXXX)"
    export GNUPGHOME

    if checked_import_key 3DD6797A5EDE9A253311C13AED3E040B19F6996E && checked_import_key 3F717988DF7D8D55A1660FC1A5ECF255B5AE77E1; then
        if ! create_sign_verify 3DD6797A5EDE9A253311C13AED3E040B19F6996E --gpg-extra "--local-user=3F717988DF7D8D55A1660FC1A5ECF255B5AE77E1"; then
            log_result "testWrongKey (Key 1)" "PASS"
        else
            log_result "testWrongKey (Key 1)" "FAIL"
        fi

        if ! create_sign_verify 3F717988DF7D8D55A1660FC1A5ECF255B5AE77E1 --gpg-extra "--local-user=3DD6797A5EDE9A253311C13AED3E040B19F6996E"; then
            log_result "testWrongKey (Key 2)" "PASS"
        else
            log_result "testWrongKey (Key 2)" "FAIL"
        fi
    else
        log_result "testWrongKey" "FAIL" "Failed to import keys"
    fi

    rm -rf "${GNUPGHOME}"
}

# Run tests
testSingleKey
testMultipleKeys
testWrongKey

echo "Tests completed. Results logged in ${LOGFILE}"
