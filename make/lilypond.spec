Name: lilypond
Version: 0.1.16
Release: 1
Copyright: GPL
Group: Applications/Publishing
Source0: pcnov095.win.tue.nl:/pub/lilypond/lilypond-0.1.16.tar.gz
Summary: A preprocessor to make TeX typeset music.
URL: http://www.stack.nl/~hanwen/lilypond
Packager: Han-Wen Nienhuys <hanwen@stack.nl>
Icon: lelie_icon.gif
Buildroot: /tmp/lilypond-install

%description 
LilyPond is the GNU Project music typesetter. This program converts
music definition files into visual or auditive output: it can typeset
formatted sheet music to a TeX file and and (mechanical) performances
to MIDI files. Features include multiple staffs, meters, clefs, keys,
lyrics, versatile input-language, cadenzas beams, slurs, triplets.

%prep
%setup
%build
./configure --enable-checking --disable-debugging --enable-printing --prefix=/usr --enable-optimise --enable-shared
make all
%install
rm -rf $RPM_BUILD_ROOT
strip lily/out/lilypond mi2mu/out/mi2mu
make -C Documentation gifs
make prefix="$RPM_BUILD_ROOT/usr" install
%files
%doc Documentation/out/AUTHORS.text Documentation/out/CodingStyle.text Documentation/out/INSTALL.text Documentation/out/MANIFESTO.text Documentation/out/convert-mudela.text Documentation/out/faq.text Documentation/out/gnu-music.text Documentation/out/index.text Documentation/out/internals.text Documentation/out/language.text Documentation/out/lilypond.text Documentation/out/links.text Documentation/out/literature.text Documentation/out/mi2mu.text Documentation/out/mudela-book.text Documentation/out/mutopia.text Documentation/out/other-packages.text BUGS TODO NEWS DEDICATION ANNOUNCE README
%doc input/abbrev.ly input/beams.ly input/cadenza.ly input/collisions.ly input/coriolan-alto.ly input/font.ly input/gallina.ly input/gallina.tex input/header.ly input/keys.ly input/kortjakje.ly input/multi.ly input/pedal.ly input/rhythm.ly input/scales.ly input/scripts.ly input/scsii-menuetto.ly input/scsii-menuetto.tex input/slurs.ly input/standchen-16.tex input/standchen-20.tex input/standchen.ly input/toccata-fuga-E.ly input/twinkle-pop.ly input/twinkle.ly input/wtk1-fugue1.ly input/wtk1-fugue2.ly input/wtk1-prelude1.ly Documentation/mudela-course.doc Documentation/mudela-man.doc 
%doc Documentation/out/lelie_logo.gif
/usr/bin/convert-mudela
/usr/bin/mudela-book
/usr/bin/lilypond
/usr/lib/libflower.so
/usr/bin/mi2mu
/usr/man/man1/mi2mu.1
/usr/man/man1/lilypond.1
/usr/man/man1/mudela-book.1
/usr/man/man1/convert-mudela.1
/usr/lib/texmf/texmf/tex/lilypond/
/usr/share/lilypond/
%post

texhash		# takes some time...

