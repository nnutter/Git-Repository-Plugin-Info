use strict;
use warnings;

use Test::Git qw(test_repository);
use Git::Repository qw(Info);

use Test::More tests => 2;

do {
    my $repo = test_repository();
    ok(!$repo->is_bare, 'is_bare returns false for non-bare repo' );
};

do {
    my $repo = test_repository(init => ['--bare']);
    ok($repo->is_bare, 'is_bare returns true for bare repo' );
};
