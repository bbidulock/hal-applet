#!/usr/bin/perl -w

use ExtUtils::MakeMaker;
my $VERSION = '0.01';
if (-d ".git") {
	$VERSION = `git describe --tags`;
	$VERSION =~ s/-.*//;
}

WriteMakefile(
	NAME => q(hal-applet),
	VERSION => $VERSION,
	LICENSE => 'perl',
	EXE_FILES => [qw(
		hal-applet
	)],
	PREREQ_PM => {
		'Getopt::Long' => 0.00,
		'Glib' => 0.00,
		'Gtk2' => 0.00,
		'Gtk2::Unique' => 0.00,
		'Net::DBus' => 0.00,
		'Net::DBus::GLib' => 0.00,
	},
	# basically strip the pod out of the .pm file and squeeze blank lines
	PM_FILTER => qq{(sed '/^=[^c]/,/^=cut/d'|cat -s)},
);

sub MY::postamble {
	return <<MAKE_FRAG;

.PHONY: install_desktop
install:: install_desktop

install_desktop:
	install -Dm644 hal-applet.desktop "\$(DESTDIR)/etc/xdg/autostart/hal-applet.desktop"
	install -Dm644 hal-applet.desktop "\$(DESTDIR)/usr/share/applications/hal-applet.desktop"

MAKE_FRAG
}
