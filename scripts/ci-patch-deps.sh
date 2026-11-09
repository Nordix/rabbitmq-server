#!/bin/sh
# Fix missing internal_user record in rabbit_common (removed in a later commit)
python3 - <<'EOF'
content = open('deps/rabbit_common/include/rabbit.hrl').read()
record = '\n-record(internal_user, {username, password_hash, tags, hashing_algorithm, limits = #{}}).\n'
content = content.replace('-record(permission,', record + '-record(permission,')
open('deps/rabbit_common/include/rabbit.hrl', 'w').write(content)
EOF

# Fix invalid deprecated attribute string form (only valid in OTP 23+)
sed -i 's/-deprecated({is_mixed_versions,1,"Use is_mixed_versions\/0 instead"})/-deprecated({is_mixed_versions,1,eventually})/' \
  deps/rabbitmq_ct_helpers/src/rabbit_ct_helpers.erl
