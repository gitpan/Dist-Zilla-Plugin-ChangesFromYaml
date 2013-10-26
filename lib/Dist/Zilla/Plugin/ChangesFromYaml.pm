package Dist::Zilla::Plugin::ChangesFromYaml;
# ABSTRACT: convert Changes from YAML to CPAN::Changes::Spec format
our $VERSION = '0.001'; # TRIAL VERSION

use Moose;
with( 'Dist::Zilla::Role::FileMunger' );
use namespace::autoclean;
use Dist::Zilla::Plugin::ChangesFromYaml::Convert qw(convert);

sub munge_file {
    my ($self, $file) = @_;

    return unless $file->name eq 'Changes';

    $file->content( convert( $file->content ) );
    $self->log_debug(
        [
            'Converte Changes from YAML to CPAN::Changes::Spec', $file->name
        ]
    );
}

__PACKAGE__->meta->make_immutable;
1;

__END__

=head1 SYNOPSIS

In your 'dist.ini':

    [ChangesFromYaml]

=head1 DESCRIPTION

This module lets you keep your Changes file in YAML format:

    version: 0.37
    date:    Fri Oct 25 21:46:59 MYT 2013
    changes:
    - 'Bugfix: Run Test::Compile tests as xt as they require optional dependencies to be present (GH issue #22)'
    - 'Testing: Added Travis-CI integration'
    - 'Makefile: Added target to update version on all packages'

and during build converts it to CPAN::Changes::Spec format

    0.37 Fri Oct 25 21:46:59 MYT 2013
     - Bugfix: Run Test::Compile tests as xt as they require optional
       dependencies to be present (GH issue #22)
     - Testing: Added Travis-CI integration
     - Makefile: Added target to update version on all packages

=head1 AUTHOR

Carlos Lima <carlos@cpan.org>

=cut
