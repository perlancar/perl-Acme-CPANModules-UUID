package Acme::CPANModules::UUID;

# AUTHORITY
# DATE
# DIST
# VERSION

use strict;
use warnings;

our $LIST = {
    summary => 'Modules that can generate immutable universally unique identifier (UUIDs)',
    description => <<'_',

UUIDs are 128-bit numbers that can be used as permanent IDs or keys in
databases. There are 5 "versions" of UUID, each might be more suitable than
others in specific cases. Version 1 (v1) UUIDs are generated from a time and a
node ID (usually the MAC address); version 2 (v2) UUIDs from an identifier
(group/user ID), a time, and a node ID; version 4 (v4) UUIDs from a
random/pseudo-random number; version 3 (v3) UUIDs from hashing a namespace using
MD5; version 5 (v5) from hashing a namespace using SHA-1.

<pm:Data::UUID> should be your first choice,

_
    entry_features => {
        v4_secure_random => {summary => 'Whether the module uses cryptographically secure pseudo-random number generator for v4 UUIDs'},
    },
    entries => [
        {
            module => 'Data::UUID',
            description => <<'_',

This module creates v1 and v2 UUIDs. Depending on the OS, for MAC address, it
usually uses a hash of hostname instead. This module is XS, so performance is
good. If you cannot use an XS module, try <pm:UUID::Tiny> instead.

The benchmark code creates 1000 v1 string UUIDs.

_
            bench_code_template => 'my $u = Data::UUID->new; $u->create for 1..1000',
            features => {
                is_xs => 1,
                is_pp => 0,
                create_v1 => 1,
                create_v2 => 1,
                create_v3 => 0,
                create_v4 => 0,
                create_v5 => 0,
            },
        },

        {
            module => 'UUID::Tiny',
            description => <<'_',

This module should be your go-to choice if you cannot use an XS module.

To create a cryptographically secure random (v4) UUIDs, use
<pm:UUID::Tiny::Patch::UseMRS>.

The benchmark code creates 1000 v1 string UUIDs.

See also: <pm:Types::UUID> which is a type library that uses Data::UUID as the
backend.

_
            bench_code_template => 'UUID::Tiny::create_uuid() for 1..1000',
            features => {
                is_xs => 0,
                is_pp => 1,
                create_v1 => 1,
                create_v2 => 0,
                create_v3 => 1,
                create_v4 => 1,
                v4_secure_random => 0,
                create_v5 => 1,
            },
        },

        {
            module => 'UUID::Random',
            description => <<'_',

This module simply uses 32 calls to Perl's C<rand()> to construct each random
hexadecimal digits of the UUID. Not really recommended, but it's dead simple.

To create a cryptographically secure random UUIDs, use
<pm:UUID::Random::Patch::UseMRS>.

The benchmark code creates 1000 v1 string UUIDs.

_
            bench_code_template => 'UUID::Random::generate() for 1..1000',
            features => {
                is_xs => 0,
                is_pp => 1,
                create_v1 => 0,
                create_v2 => 0,
                create_v3 => 0,
                create_v4 => 1,
                v4_secure_random => 0,
                create_v5 => 0,
            },
        },
    ],
};

1;
# ABSTRACT:
