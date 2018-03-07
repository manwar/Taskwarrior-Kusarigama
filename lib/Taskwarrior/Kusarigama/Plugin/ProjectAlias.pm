package Taskwarrior::Kusarigama::Plugin::ProjectAlias;
#ABSTRACT: turn @foo into project:foo

=head1 SYNOPSIS

    $ task add do something @projectA

=head1 DESCRIPTION

Expands C<@foo> into C<project:foo>.

=cut

use strict;
use warnings;

use Moo;

extends 'Taskwarrior::Kusarigama::Plugin';

with 'Taskwarrior::Kusarigama::Hook::OnAdd';
with 'Taskwarrior::Kusarigama::Hook::OnModify';

sub on_add {
    my( $self, $task ) = @_;

    my $desc = $task->{description};

    $desc =~ s/(^|\s)\@(\w+)\s*/$1/ or return;

    $task->{project} = $2;

    $task->{description} = $desc;
}

sub on_modify { 
    my $self = shift;
    $self->on_add(@_);
}

1;

