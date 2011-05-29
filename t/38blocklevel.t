use warnings;
use strict;

use FindBin '$Bin';
use Test::More tests => 2;

require "$Bin/20fulldocs-text-multimarkdown.t";

use_ok('Text::MultiMarkdown');

my $m;
sub test (&) {
  my($block) = @_;

  $m = Text::MultiMarkdown->new;
  $block->();
}

test {
  my $markdown = <<EOMarkdown;
<div id="myid" markdown="1">
Use the [Google][1]!

[1]: http://www.google.com/
</div>
EOMarkdown

  difftest($m->markdown($markdown), <<EOExpected, "processed link inside div");
<div id="myid">
<p>Use the <a href="http://www.google.com/">Google</a>!</p>
</div>
EOExpected
};
