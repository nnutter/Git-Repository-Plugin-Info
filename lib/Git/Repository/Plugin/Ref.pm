package Git::Repository::Plugin::Ref;
use parent qw(Git::Repository::Plugin);

use 5.008005;
use strict;
use warnings;

our $VERSION = "0.01";

sub _keywords { qw(
    has_ref
    has_branch
    has_tag
) }

sub has_ref {
    my $repo = shift;
    my $ref_name = shift;
    $repo->run('show-ref', '--verify', '--quiet', $ref_name);
    return ($? == 0);
}

sub has_branch {
    my $repo = shift;
    my $branch_name = shift;

    # normalize branch name to prevent ambiguous matches to tags, etc.
    unless (index($branch_name, 'refs/heads/') == 0) {
        $branch_name = 'refs/heads/' . $branch_name;
    }

    return $repo->has_ref($branch_name);
}

sub has_tag {
    my $repo = shift;
    my $tag_name = shift;

    # normalize tag name to prevent ambiguous matches to tags, etc.
    unless (index($tag_name, 'refs/tags/') == 0) {
        $tag_name = 'refs/tags/' . $tag_name;
    }

    return $repo->has_ref($tag_name);
}

1;

__END__

=encoding utf-8

=head1 NAME

Git::Repository::Plugin::Ref - Check existence of refs using Git::Repository

=head1 SYNOPSIS

    use Git::Repository 'Ref';

    my $r = Git::Repository->new();

    $r->has_tag('some_tag');
    $r->has_branch('some_branch');

=head1 DESCRIPTION

Adds several methods to L<Git::Repository> objects to check if a Git reference
exists.

=head1 METHODS

=head2 has_ref($ref_name)

Check if C<$ref_name> exists in the L<Git::Repository>.

=head2 has_branch($branch_name)

Check if a branch named C<$branch_name> exists in the L<Git::Repository>.

=head2 has_tag($tag_name)

Check if tag named C<$tag_name> exists in the L<Git::Repository>.

=head1 LICENSE

Copyright (C) Nathaniel Nutter.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Nathaniel Nutter E<lt>nnutter@cpan.orgE<gt>

=cut

