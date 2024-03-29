unit radios;

interface

const
  genrelist: array[0..7] of string = (
    'Eletronic',
    'Downtempo',
    'Rock/Metal',
    'Ecletic',
    'Hip-Hop',
    'Old/Classical',
    'Others',
    'Brasileiras',
    );

const
  chn_eletronic: array[0..0] of string = (
	'Trance ( sense.fm )',
	'Progressive ( sense.fm )',
	'Psy ( schizoid )',
	'Psy Prog ( schizoid )',
    'Dubstep ( dubstep.fm )',
    'House Funky ( kif )',
    'Hardcore ( coretime )',
    'Hardcore ( hardcoreradio )',
    'Hardstyle ( hard.fm )',
    'Hardstyle ( hardbase )',
    'House Eletro ( housetime )',
    'House SoulFull ( freshhouse )',
    'House SoulFull ( deepinside )',
    'Trance ( afterhours )',
    'Dance ( vibefm )',
    'Dance ( freshfm )',
    'Dance ( sky )',
    'Club ( DI )',
    'Club ( c89.5 )',
    'Club ( blitz )',
    'Club ( playdio )',
    'Club ( techno4ever )',
    'Club ( pulsradio )',
    'Club ( technobase )',
    'Club ( frenchkiss )',
    'Club ( radioseven )',
    'Club ( rautemusik )',
    'Club ( 1.fm )',
    'Dance ( 1.fm )',
    'Trance ( 1.fm )',
    'House Funky ( rautemusik )',
    'Progressive ( soma )',
    'IDM ( soma )',
    'Psy ( philosomatika )',
    'Psy ( psyradio )',
    'Psy Prog ( psyradio )',
    'Trance ( neradio )',
    'Hardstyle ( neradio )',
    'Trance ( trancebase )',
    'Drum''n''Bass ( dnbradio )',
    'Drum''n''Bass ( bassdrive)',
    'House Eletro ( DI )',
    'House Tribal ( DI )',
    'House Funky ( DI )',
    'Hardstyle ( DI )',
    'Trance ( DI )',
    'Trance Vocal ( DI )',
    'Eurodance ( DI )',
    'Eurodance Classic ( DI )',
	'House Latin ( DI )',
    'House ( DI )',
    'House Classic ( DI )',
    'House Disco ( DI )',
    'House SoulFull ( DI )',
    'House Tech ( DI )',
    'Harddance ( DI )',
    'Techno ( DI )',
    'Progressive ( DI )',
    'Psy ( DI )',
    'Hardcore ( DI )',
    'DJ-Mixes ( DI )',
    'DJ-Mixes ( DI )',
    'Drum''n''Bass ( DI )',
    'Drum''n''Bass Liquid ( DI )',
    'Techno Classic ( DI )',
    'Trance Classic ( DI )',
    'Dubstep ( DI )',
    'BreakBeat ( DI )',
    'Futurepop ( DI )',
    'Gabber ( DI )',
    'Jumpstyle ( fear )',
    'Hardstyle ( fear )',
    'Hardcore ( fear )',
    'Dance ( 181.fm )',
    'Eurodance ( 181.fm )',
    'Psy Mixes ( psychedelik )',
    'Psy ( psychedelik )',
    'Psy Prog ( psychedelik )',
    'Psy Dark ( psychedelik )',
    'Psy Dark ( triplag )',
    'Psy Darkbient ( triplag )',
    'Progressive ( frisky )',
    'Alternative ( 1.fm )',
    'Dance ( fg radio )',
    'Dance ( ibizaglobal )',
    'Dance ( fusionchicago )',
    'Dance ( mixnation )',
    // industrial
    'Post Industrial ( gothville )',
    'Post Industrial ( gothradio )',
    'Post Industrial ( darkness )',
    'Post Industrial ( tormented )',
    'Post Industrial ( digitalgunfire )',
    'Post Industrial ( ultradark )',
    'Post Industrial ( schwarze )',
    'Post Industrial ( rantradio )',
    'Post Industrial ( realindustrial )',
    );

const
  pls_eletronic: array[0..0] of string = (
	'http://www.sense.fm/192k-high.m3u',
	'http://www.sense.fm/192k-prog.m3u',
	'http://schizoid.in/schizoid-psy.pls',
	'http://schizoid.in/schizoid-prog.pls',
    'http://www.dubstep.fm/listen.pls',
    'http://www.kifradio.com/www.kifradio.com.m3u',
    'http://mp3.coretime.fm/listen.pls',
    'http://www.hardcoreradio.nl/rhr.m3u',
    'http://files.hard.fm/128.pls',
    'http://mp3.hardbase.fm/listen.pls',
    'http://high.housetime.fm/listen.pls',
    'http://listen.freshhouse.fm/listen.pls',
    'http://www.deepinside.co.uk/deepinside.m3u',
    'http://stats.ah.fm/dynamicplaylist.m3u?quality=96',
    'http://www.vibefm.ro/listen.pls',
    'http://www.fresh.fm/media/audio/ListenHigh.pls',
    'http://listen.sky.fm/public1/dancehits.pls',
    'http://listen.di.fm/public3/club.pls',
    'http://c895worldwide.com/web/streaming/c895sc128.pls',
    'http://listen.blitz-radio.de/listen.pls',
    'http://www.playdio.se/bredband.pls',
    'http://listen.to.techno4ever.net/dsl/mp3',
    'http://www.pulsradio.com/pls/puls-adsl.m3u',
    'http://listen.technobase.fm/dsl.pls',
    'http://stream.frenchkissfm.com/listen.pls',
    'http://play.radioseven.se/128.pls',
    'http://club-office.rautemusik.fm/listen.pls',
    'http://www.1.fm/TuneIn/WM/energyclub128k/Listen.aspx',
    'http://www.1.fm/TuneIn/WM/energydance128k/Listen.aspx',
    'http://www.1.fm/trance.pls',
    'http://funky-office.rautemusik.fm/listen.pls',
    'http://somafm.com/tags.pls',
    'http://somafm.com/cliqhop.pls',
    'http://205.188.215.229:8012/listen.pls',
    'http://streamer.psyradio.org:8030/listen.pls',
    'http://streamer.psyradio.org:8010/listen.pls',
    'http://listen.neradio.fm/listen.pls',
    'http://www.neradio.se/listen.pls',
    'http://mp3.trancebase.fm/listen.pls',
    'http://www.dnbradio.com/hi.pls',
    'http://www.bassdrive.com/v2/streams/BassDrive.pls',
    'http://listen.di.fm/public3/electro.pls',
    'http://listen.di.fm/public3/tribalhouse.pls',
    'http://listen.di.fm/public3/funkyhouse.pls',
    'http://listen.di.fm/public3/hardstyle.pls',
    'http://listen.di.fm/public3/trance.pls',
    'http://listen.di.fm/public3/vocaltrance.pls',
    'http://listen.di.fm/public3/eurodance.pls',
    'http://listen.di.fm/public3/classiceurodance.pls',
	'http://listen.di.fm/public3/latinhouse.pls',
    'http://listen.di.fm/public3/house.pls',
    'http://listen.di.fm/public3/oldschoolhouse.pls',
    'http://listen.di.fm/public3/discohouse.pls',
    'http://listen.di.fm/public3/soulfulhouse.pls',
    'http://listen.di.fm/public3/techhouse.pls',
    'http://listen.di.fm/public3/harddance.pls',
    'http://listen.di.fm/public3/techno.pls',
    'http://listen.di.fm/public3/progressive.pls',
    'http://listen.di.fm/public3/goapsy.pls',
    'http://listen.di.fm/public3/hardcore.pls',
    'http://listen.di.fm/public3/djmixes.pls',
    'http://schizoid.in/schizoid-edm.pls',
    'http://listen.di.fm/public3/drumandbass.pls',
    'http://listen.di.fm/public3/liquiddnb.pls',
    'http://listen.di.fm/public3/classictechno.pls',
    'http://listen.di.fm/public3/classictrance.pls',
    'http://listen.di.fm/public3/dubstep.pls',
    'http://listen.di.fm/public3/breaks.pls',
    'http://listen.di.fm/public3/futuresynthpop.pls',
    'http://listen.di.fm/public3/gabber.pls',
    'http://www.fear.fm/streamrelay/playlist/hard.pls',
    'http://www.fear.fm/streamrelay/playlist/harder.pls',
    'http://www.fear.fm/streamrelay/playlist/hardest.pls',
    'http://www.181.fm/winamp.pls?station=181-energy98',
    'http://www.181.fm/winamp.pls?station=181-energy93',
    'http://www.psychedelik.com/tunein-lives_mixes.pls',
    'http://www.psychedelik.com/tunein-psy.pls',
    'http://www.psychedelik.com/tunein-prog.pls',
    'http://www.psychedelik.com/tunein-dark.pls',
    'http://www.triplag.com/webradio/darkpsy/triplag-darkpsy.php',
    'http://www.triplag.com/webradio/chilltrip/triplag-chilltrip.php',
    'http://friskyradio.com/frisky.m3u',
    'http://www.1.fm/electronica.pls',
    'http://fg.impek.tv/listen.pls',
    'http://s6.viastreaming.net:7010/listen.pls',
    'http://streams.fusionchicago.com/128.pls',
    'http://www.mixnation.de/listen.pls',
    // industrial
    'http://radio.gothville.com:8000/listen.pls',
    'http://67.78.148.34:8002/listen.pls',
    'http://radio.darkness.com/listen.pls',
    'http://playlist.tormentedradio.com/radioG.pls',
    'http://www.digitalgunfire.com/dg.pls',
    'http://www.ultradarkradio.com/listen.pls',
    'http://www.schwarze-welle.com/play.m3u',
    'http://www.rantmedia.ca/industrial/rr-industrial128.pls',
    'http://radio.realindustrialradio.com:8000/listen.pls',
    );


const
  chn_downtempo: array[0..0] of string = (
	'Chillout ( schizoid )',
    'Dream Pop ( soma )',
    'Post Rock ( soma )',
    'Ambient ( bluemars )',
    'Ambient Space ( bluemars )',
    'Ambient Drone ( bluemars )',
    'Minimal ( deepmix )',
    'Chillout ( 1.fm )',
    'Lounge ( rautemusik )',
    'Lounge ( smoothlounge )',
    'Lounge ( lounge-radio )',
    'Chillout ( soma )',
    'Ambient House ( soma )',
    'Ambient Dark ( soma )',
    'Ambient Space ( soma )',
    'Ambient Drone ( soma )',
    'Lounge Exotica ( soma )',
    'Chillout ( psyradio )',
    'Minimal ( psyradio )',
    'New Age ( sky )',
	'New Age Vocal ( sky )',
    'Minimal ( DI )',
    'Chillout ( DI )',
    'Lounge ( DI )',
    'Lounge Downtempo ( sky )',
    'Ambient ( DI )',
    'Ambient Drone ( DI )',
    'Chillout ( bluefm )',
    'Chillout ( 181.fm )',
    'Chillout ( psychedelik )',
	'Chillout ( buzzoutroom )',
    'PsyChill ( DI )',
    'Chillout Beats ( DI )',
	'Ambient Space ( DI )',
    'Chillout Beats ( entranced.fm )',
    'Chillout Beats ( sky )',
    );

const
  pls_downtempo: array[0..0] of string = (
	'http://schizoid.in/schizoid-chill.pls',
    'http://somafm.com/lush.pls',
    'http://somafm.com/digitalis.pls',
    'http://207.200.96.225:8024/listen.pls',
    'http://207.200.96.225:8020/listen.pls',
    'http://207.200.96.225:8022/listen.pls',
    'http://deepmix.ru/deepmix128.pls',
    'http://www.1.fm/tcl.pls',
    'http://lounge-office.rautemusik.fm/listen.pls',
    'http://www.smoothlounge.com/streams/smoothlounge_128.pls',
    'http://www.lounge-radio.com/listen128.m3u',
    'http://somafm.com/groovesalad.pls',
    'http://somafm.com/beatblender.pls',
    'http://somafm.com/doomed.pls',
    'http://somafm.com/spacestation.pls',
    'http://somafm.com/dronezone.pls',
    'http://somafm.com/illstreet.pls',
    'http://streamer.psyradio.org:8020/listen.pls',
    'http://streamer.psyradio.org:8040/listen.pls',
    'http://listen.sky.fm/public1/newage.pls',
	'http://listen.sky.fm/public1/vocalnewage.pls',
    'http://listen.di.fm/public3/minimal.pls',
    'http://listen.di.fm/public3/chillout.pls',
    'http://listen.di.fm/public3/lounge.pls',
    'http://listen.sky.fm/public1/datempolounge.pls',
    'http://listen.di.fm/public3/ambient.pls',
    'http://listen.di.fm/public3/spacemusic.pls',
    'http://bluefm.net/listen.pls',
    'http://www.181.fm/winamp.pls?station=181-chilled',
    'http://88.191.38.140:8002/listen.pls',
	'http://www.buzzoutroom.com/listen.pls',
    'http://listen.di.fm/public3/psychill.pls',
    'http://listen.di.fm/public3/chilloutdreams.pls',
	'http://listen.di.fm/public3/spacemusic.pls',
    'http://loudcity.com/stations/entranced-fm/files/show/aacplus-hi.pls',
    'http://listen.sky.fm/public1/dreamscapes.pls',
    );

const
  chn_rockmetal: array[0..0] of string = (
    'Classic Rock ( absolute )',
    'Death Metal ( death.fm )',
    '80''s Rock ( 181.fm )',
    'Indie Rock ( soma )',
    'Punk Rock ( idobi )',
    'Classic Rock ( 977music )',
    'Alternative ( 977music )',
    'Rock Metal ( 525 )',
    'Rock Metal ( cxraggression )',
    'Rock Metal ( cxrmetal )',
    'Rock Metal ( cxrgrit )',
    'Classic Rock ( sky )',
    'Indie Rock ( sky )',
    'Punk Rock ( sky )',
    'Alternative ( sky )',
	'Rock Metal ( therock.181.fm )',
    'Rock Metal ( rock181.181.fm )',
    'Alternative ( 181.fm )',
    'Classic Rock ( 181. fm)',
    'Rock Metal ( rautemusik )',
    'Rock Metal ( x.1.fm )',
    'Rock Metal ( hv.1.fm )',
    'Rock Metal ( metalonly )',
    'Rock Metal ( kinkfm )',
    'Rock Metal ( rocky )',
    'Classic Rock ( rock radio1 )',
    'Classic Rock ( rock&rollfm )'
    );

const
  pls_rockmetal: array[0..0] of string = (
    'http://network.absoluteradio.co.uk/core/audio/mp3/live.pls?service=vcbb',
    'http://loudcity.com/stations/death-fm/files/show/aacplus-hi.pls',
    'http://www.181.fm/winamp.pls?station=181-hairband',
    'http://somafm.com/indiepop.pls',
    'http://idobi.com/services/iradio.pls',
    'http://www.977music.com/itunes/classicrock.pls',
    'http://www.977music.com/itunes/alternative.pls',
    'http://fastcast4u.com:9256/listen.pls',
    'http://www.chronixradio.com/stations/chronixaggression/listen/listen.pls',
    'http://www.chronixradio.com/stations/cxrmetal/listen/listen.pls',
    'http://www.chronixradio.com/stations/cxrgrit/listen/listen.pls',
    'http://listen.sky.fm/public1/classicrock.pls',
    'http://listen.sky.fm/public1/indierock.pls',
    'http://listen.sky.fm/public1/poppunk.pls',
    'http://listen.sky.fm/public1/altrock.pls',
	'http://www.181.fm/winamp.pls?station=181-hardrock',
    'http://www.181.fm/winamp.pls?station=181-rock',
    'http://www.181.fm/winamp.pls?station=181-buzz',
    'http://www.181.fm/winamp.pls?station=181-eagle',
    'http://extreme-office.rautemusik.fm/listen.pls',
    'http://www.1.fm/x.pls',
    'http://www.1.fm/hv.pls',
    'http://metal-only.de/listen.pls',
    'http://www.kinkfm.com/streams/kink_aardschok.m3u',
    'http://www.rockyfm.de/listen.pls',
    'http://91.121.201.88:8000/listen.pls',
    'http://tunein.swcast.net/launch.cgi/dade921/hi-band.pls'
    );

const
  chn_ecletic: array[0..0] of string = (
    'Ecletic ( wadio )',
    'Ecletic ( iloveradio )',
    'Ecletic ( maxxhits )',
    'Ecletic ( eye97 )',
    'Ecletic ( paradise )',
    'Ecletic ( enjoystation )',
    'Ecletic ( sky )',
    'Ecletic ( 1.fm )',
    'Ecletic ( hitz.977music )',
    'Ecletic ( mix.977music )',
    'Ecletic ( frequence3 )',
    'Ecletic ( power.181.fm )',
    'Ecletic ( mix.181.fm )',
    'Ecletic ( point.181.fm )',
    'Ecletic ( party.181.fm )',
    'Ecletic ( office.181.fm )',
    'Ecletic ( rautemusik )',
    'Ecletic ( HitzRadio )',
    'Ecletic ( absolute )'
    );

const
  pls_ecletic: array[0..0] of string = (
    'http://wad.io/listen/everywhere',
    'http://www.iloveradio.de/listen.pls',
    'http://www.maxxhits.eu/listen/listen-winamp.m3u',
    'http://loudcity.com/stations/eye97/files/show/eye97.pls',
    'http://www.radioparadise.com/musiclinks/rp_128-1.m3u',
    'http://www.enjoystation.net/player/mp3.m3u',
    'http://listen.sky.fm/public1/tophits.pls',
    'http://www.1.fm/top40.pls',
    'http://www.977music.com/977hitz.pls',
    'http://www.977music.com/itunes/mix.pls',
    'http://streams.frequence3.fr/mp3-192.m3u',
    'http://www.181.fm/winamp.pls?station=181-power',
    'http://www.181.fm/winamp.pls?station=181-themix',
    'http://www.181.fm/winamp.pls?station=181-thepoint',
    'http://www.181.fm/winamp.pls?station=181-party',
    'http://www.181.fm/winamp.pls?station=181-office',
    'http://main-office.rautemusik.fm/listen.pls',
    'http://www.hitzradio.com/hitzradio.pls'
    'http://network.absoluteradio.co.uk/core/audio/mp3/live.pls?service=vrbb',
    );

const
  chn_hiphop: array[0..0] of string = (
    'HipHop ( blackbeats )',
    'HipHop ( powerhitz )',
    'HipHop ( thugzone )',
    'HipHop ( defjay )',
    'HipHop ( rautemusik )',
    'HipHop ( 1.fm )',
    'HipHop ( hot108 )',
    'HipHop ( beat.181.fm )',
    'HipHop ( box.181.fm )',
    'HipHop ( sky )',
    'HipHop ( R&B.181.fm )',
    'Classic Rap ( sky )',
    'HipHop ( smoothbeats )',
    'HipHop ( truehiphop )',
    );

const
  pls_hiphop: array[0..0] of string = (
    'http://www.blackbeats.fm/listen.m3u',
    'http://www.powerhitz.com/ph.pls',
    'http://www.thugzone.com/broadband-128.pls',
    'http://www.defjay.com/listen.pls',
    'http://jam-office.rautemusik.fm/listen.pls',
    'http://www.1.fm/TuneIn/WM/energyjamz128k/Listen.aspx',
    'http://www.hot108.com/hot108.pls',
    'http://www.181.fm/winamp.pls?station=181-beat',
    'http://www.181.fm/winamp.pls?station=181-thebox',
    'http://listen.sky.fm/public1/urbanjamz.pls',
    'http://www.181.fm/winamp.pls?station=181-rnb&style=&description=True%20R&B',
    'http://listen.sky.fm/public1/classicrap.pls',
    'http://www.smoothbeats.com/listen.pls',
    'http://www.truehiphopfm.de/playlists/playlist.php?type=pls',
    );

const
  chn_oldmusic: array[0..0] of string = (
    '80''s ( absolute )',
    'Classical ( adagio.fm )',
    '80''s ( 1980s.fm )',
	'New Wave ( soma )',
    'New Wave ( nigel )',
    '60''s ( sky )',
    '70''s ( sky )',
    '80''s ( sky )',
    '90''s ( star.181.fm )',
    'Classic Hits ( 181.fm )',
    '80''s ( awesome.181.fm )',
    '80''s ( lite.181.fm )',
    '90''s ( alternative.181.fm )',
    '80''s ( 977music )',
    '90''s ( 977music )',
    '50''s-80''s ( rautemusik )',
    'Classical ( sky )',
    'Baroque ( 1.fm )',
    'Opera ( 1.fm )',
    'Classical ( 1.fm )',
    'Disco ( 1.fm )',
    '80''s ( flashback )',
    '80''s ( asf )',
    '80''s ( chaos )'
    );

const
  pls_oldmusic: array[0..0] of string = (
    'http://network.absoluteradio.co.uk/core/audio/mp3/live.pls?service=a8',
    'http://loudcity.com/stations/adagio-fm/files/show/aacplus-hi.pls',
    'http://loudcity.com/stations/1980s-fm/files/show/aacplus-hi.pls',
	'http://somafm.com/u80s.pls',
    'http://stream.radionigel.com:8010/listen.pls',
    'http://listen.sky.fm/public1/oldies.pls',
    'http://listen.sky.fm/public1/hit70s.pls',
    'http://listen.sky.fm/public1/the80s.pls',
    'http://www.181.fm/winamp.pls?station=181-star90s',
    'http://www.181.fm/winamp.pls?station=181-greatoldies',
    'http://www.181.fm/winamp.pls?station=181-awesome80s',
    'http://www.181.fm/winamp.pls?station=181-lite80s',
    'http://www.181.fm/winamp.pls?station=181-90salt',
    'http://www.977music.com/977hi.pls',
    'http://www.977music.com/itunes/90s.pls',
    'http://goldies-high.rautemusik.fm/listen.pls',
    'http://listen.sky.fm/public1/classical.pls',
    'http://www.1.fm/baroque.pls',
    'http://www.1.fm/opera.pls',
    'http://www.1.fm/classical.pls',
    'http://www.1.fm/disco.pls',
    'http://www.1.fm/fa128k.pls',
    'http://www.atlanticsoundfactory.com/asfbb.pls',
    'http://www.chaos-radio.net/stream/listen.m3u'
    );

const
  chn_misc: array[0..0] of string = (
  	'Nature ( sky )',
	'Relaxation ( sky )',
    'Blues ( bellyup4blues )',
    'Salsa ( La X )',
    'Tango ( tangorosario )',
    // 'Latino ( romanticafm )',
    'Folk ( liveireland )',
    'Jazz Acid ( soma )',
    'Jazz Nu ( soma )',
    'Country ( soma )',
    'Country ( 977music )',
    'Jazz Vocal ( 1.fm )',
    'Jazz Smooth ( 977music )',
    'Jazz Smooth ( swissgroove )',
    'Jazz Smooth ( 1.fm )',
    'Jazz Smooth ( smoothjazz )',
    'Jazz Smooth ( 181.fm )',
    'Easy Listening ( 181.fm )',
    'Easy Listening ( slowradio )',
    'Country ( 181.fm )',
    'Country Classic ( 181.fm )',
    'Country ( 1.fm )',
    'Blues ( 1.fm )',
    'Reggae ( 1.fm )',
    'Beatles tribute ( sky )',
    'Reggae ( sky )',
    'Easy Listening ( sky )',
    'Jazz Vocal Smooth ( sky )',
    'Jazz Classics ( sky )',
    'Jazz Smooth ( sky )',
    'Jazz Uptempo ( sky )',
    'Jazz Bebop ( sky )',
    'Flamenco ( sky )',
    'Piano Trio ( sky )',
    'Piano Solo ( sky )',
    'World ( sky )',
	'Jazz Smooth 24''7  ( sky )',
    'Jazz Piano ( sky )',
    'Bossanova ( sky )',
    'Soundtracks ( sky )',
    'Gospel ( sky )',
    'Salsa ( sky )',
    'Jazz Nu ( sky )',
    'American Classics ( sky )',
    'Jpop/Anime ( kawaii )',
    'Jpop/Anime ( armitage''s )',
    'Jpop/Anime ( Anime Academy )',
    'Jpop/Anime ( AnimeNfo )',
    'Games ( VGamp )',
    'Arabic ( darvish )',
    'Soundtracks ( cinemix )',
    'Soundtracks ( streamingsoundtracks )',
    'World ( soma )',
    'Chiptune ( DI )',
    'Jpop ( sky )',
    'Romantica ( sky )',
    );

const
  pls_misc: array[0..0] of string = (
  	'http://listen.sky.fm/public1/nature.pls',
	'http://listen.sky.fm/public1/relaxation.pls',
    'http://64.62.252.134:5100/listen.pls',
    'http://laxestereo.com/proserv1.pls',
    'http://200.69.237.185:8000/listen.pls',
    // 'http://208.53.170.26:8910/listen.pls',
    'http://www.liveireland.com/live.pls',
    'http://somafm.com/secretagent.pls',
    'http://somafm.com/sonicuniverse.pls',
    'http://somafm.com/bootliquor.pls',
    'http://www.977music.com/977hicountry.pls',
    'http://www.1.fm/ajazz128k.pls',
    'http://www.977music.com/itunes/jazz.pls',
    'http://www.swissgroove.ch/listen.m3u',
    'http://www.1.fm/jazz.pls',
    'http://smoothjazz.com/streams/smoothjazz_128.pls',
    'http://www.181.fm/winamp.pls?station=181-breeze',
    'http://www.181.fm/winamp.pls?station=181-heart',
    'http://streams.slowradio.com/index.php?id=winamp',
    'http://www.181.fm/winamp.pls?station=181-kickincountry',
    'http://www.181.fm/winamp.pls?station=181-highway',
    'http://www.1.fm/country.pls',
    'http://www.1.fm/blues.pls',
    'http://www.1.fm/reggae.pls',
    'http://listen.sky.fm/public1/beatles.pls',
    'http://listen.sky.fm/public1/rootsreggae.pls',
    'http://listen.sky.fm/public1/lovemusic.pls',
    'http://listen.sky.fm/public1/vocalsmoothjazz.pls',
    'http://listen.sky.fm/public1/jazzclassics.pls',
    'http://listen.sky.fm/public1/smoothjazz.pls',
    'http://listen.sky.fm/public1/uptemposmoothjazz.pls',
    'http://listen.sky.fm/public1/bebop.pls',
    'http://listen.sky.fm/public1/guitar.pls',
    'http://listen.sky.fm/public1/classicalpianotrios.pls',
    'http://listen.sky.fm/public1/solopiano.pls',
    'http://listen.sky.fm/public1/world.pls',
	'http://listen.sky.fm/public1/smoothjazz247.pls',
    'http://listen.sky.fm/public1/pianojazz.pls',
    'http://listen.sky.fm/public1/bossanova.pls',
    'http://listen.sky.fm/public1/soundtracks.pls',
    'http://listen.sky.fm/public1/christian.pls',
    'http://listen.sky.fm/public1/salsa.pls',
    'http://listen.sky.fm/public1/jazz.pls',
    'http://listen.sky.fm/public1/americansongbook.pls',
    'http://kawaii-radio.net/listen.m3u',
    'http://albionys.net:8005/listen.pls',
    'http://www.animeacademyradio.net/listen.m3u',
    'http://www.animenfo.com/radio/listen.m3u',
    'http://vgamp.com/listen128.pls',
    'http://207.200.96.228:8078/listen.pls',
    'http://loudcity.com/stations/cinemix/files/show/mp3-High.pls'
    'http://loudcity.com/stations/streamingsoundtracks-com/files/show/aacplus-hi.asx',
    'http://somafm.com/suburbsofgoa.pls',
    'http://listen.di.fm/public3/chiptunes.pls',
    'http://listen.sky.fm/public1/jpop.pls',
    'http://listen.sky.fm/public1/romantica.pls',
    );

const
  chn_brasil: array[0..0] of string = (
    'Popular ( gaucha )',
    'Mpb ( novabrasil )',
    'Popular ( bandeirantes )',
    'Ecletic ( metropolitana )',
    'Ecletic ( jbfm )',
    'Jazz Smooth ( jbfm )',
    'Rock Classic ( cidadeclassicrock )',
    'Rock Nacional ( cidaderockbrasil )',
    'Rock Metal ( cidadewebmetal )',
    'Mpb ( mpbfm )',
    'Caipira ( violaviva )',
    'Ecletic ( interativa )',
    'Ecletic ( radiofusion )',
    'Ecletic ( radiozone )',
    'Psy ( radiodaweb )',
    'Rock ( cidadewebrock )',
    'Ecletic ( giga )',
    'Ecletic ( circuitomix )',
    'Ecletic ( ritmobrasil )',
    'Ecletic ( megasom )',
    'Ecletic ( tribunafm )',
    'Noticias ( jovenpanam )',
    'Noticias ( cbn.sp )',
    'Noticias ( cbn.rj )',
    'Noticias ( cbn.brasilia )',
    'Noticias ( cbn.bh )',
    'Popular ( tupi.rj )',
    'Popular ( tupi.fm )',
    'Rock Classic ( kissfm )',
    'Ecletic ( redeblitz )',
    'Ecletic ( jovempanfm )',
    'Ecletic ( radiorox )',
    'Ecletic ( hits.transamerica )',
    'Ecletic ( pop.transamerica )',
    'Ecletic ( light.transamerica )',
    'Ecletic ( japan.transamerica )',
    'Ecletic ( mixfm )',
    'Ecletic ( totalshare )',
    'Ecletic ( beat98 )',
    'Ecletic ( globo.fm )',
    'Popular ( globo.am.sp )',
    'Popular ( globo.am.rj )',
    'Popular ( globo.am.mg )',
    'Rock ( sporttv )',
    'Ecletic ( multishow )',
    'Classicos ( gnt )',
    'Japan/Anime ( radioblast )',
    'Funk ( estacaofunk )',
    'Ecletic ( paradiso )',
    'Pagode ( pagofunk )',
    'Mpb ( brasilmpb )',
    'Rock ( poprock )',
    'Folk ( valkyria )',
    );

const
  pls_brasil: array[0..0] of string = (
    'mms://gruporbs-gaucha-fm-rs.wm.llnwd.net/gruporbs_Gaucha_FM_RS?channel=232',
    'http://cdn.upx.net.br/listen/00086_1.wmx',
    'mms://servidor25.crossdigital.com.br:8000/bandeirantesam',
    'http://metropolitanafm.uol.com.br/ao-vivo/sao-paulo01.asx',
    'mms://200.222.115.52/OiFM_JBFM',
    'mms://200.222.115.50/CidadeWebRock_JBSmoothJazz',
    'mms://200.222.115.52/CidadeWebRock_ClassicRock',
    'mms://200.222.115.52/CidadeWebRock_RockBrasil',
    'mms://200.222.115.52/CidadeWebRock_Metal',
    'http://www.mpbfm.com.br/radinho.asx',
    'http://base2.streamingbrasil.com.br:8116/listen.pls',
    'http://www.interativafm.net/interativa.m3u',
    'http://www.radiofusion.com.br/listen.m3u',
    'http://www.radiozone.com.br/player/winamp.m3u',
    'http://www.radiodaweb.com/aovivo.m3u',
    'mms://200.222.115.50/cidadewebrock_cidadewebrock128',
    'http://wms2.corptv.com.br:8000/listen.pls',
    'http://www.circuitomix.com.br/circuitomix.pls',
    'http://www.ritmobrasil.com/RitmoBrasil.pls',
    'http://www.radiowebtv.com/server/megasom/megasom.m3u',
    'mms://200.203.183.10/TribunaFM',
    'mms://p.mm.uol.com.br/ampan',
    'http://cbn.globoradio.globo.com/playlist/asxAoVivo.php?praca=SP',
    'http://cbn.globoradio.globo.com/playlist/asxAoVivo.php?praca=RJ',
    'http://cbn.globoradio.globo.com/playlist/asxAoVivo.php?praca=BSB',
    'http://cbn.globoradio.globo.com/playlist/asxAoVivo.php?praca=BH',
    'mms://dedicado.tupi.am:8000/tupiaudio',
    'http://www.crosshost.com.br/cbs/tupifm/listen.pls',
    'http://www.crosshost.com.br/cbs/kiss/ouvir.m3u',
    'http://www.redeblitz.com.br/playerblitz/playlist.asx',
    'http://jovempanfm.virgula.uol.com.br/estudio/jpsp.asx',
    'mms://200.222.115.51/radiorox_radiorox',
    'mms://wmedia.telium.com.br/transsphits',
    'mms://wmedia.telium.com.br/transsppop64',
    'mms://wmedia.telium.com.br/transsplight',
    'mms://transastream.dyndns.org/transapop',
    'http://p.mm.uol.com.br/mixfm',
    'http://totalshare.com.br/radio/player-winamp.m3u',
    'http://beat98.globoradio.globo.com/playlist/asxAoVivo.php?praca=Beat98',
    'http://wmsgr.globo.com/webmedia/ObterPathMidia?usuario=sgr01&tipo=live&path=/sgr_off_globofmrj_live.wma&midiaId=505114&ext.asx&output=ASX',
    'http://wmsgr.globo.com/webmedia/ObterPathMidia?usuario=sgr01&tipo=live&path=/sgr_off_globoamsp_live.wma&midiaId=511329&ext.asx&output=ASX',
    'http://wmsgr.globo.com/webmedia/ObterPathMidia?usuario=sgr01&tipo=live&path=/sgr_off_globoamrj_live.wma&midiaId=505105&ext.asx&output=ASX',
    'http://wmsgr.globo.com/webmedia/ObterPathMidia?usuario=sgr01&tipo=live&path=/sgr_off_globoambh_live.wma&midiaId=519058&ext.asx&output=ASX',
    'http://wmsgr.globo.com/webmedia/ObterPathMidia?usuario=sgr01&tipo=live&path=/sgr_off_sportv_live.wma&midiaId=511317&ext=.asx&output=ASX',
    'http://wmsgr.globo.com/webmedia/ObterPathMidia?usuario=sgr01&tipo=live&path=/sgr_off_multishow_live.wma&midiaId=581681&ext.asx&output=ASX',
    'http://wmsgr.globo.com/webmedia/ObterPathMidia?usuario=sgr01&tipo=live&path=/sgr_off_gnt_live.wma&midiaId=510705&ext.asx&output=ASX',
    'http://ouvir.radioblast.com.br/',
    'http://player.redefx.com.br/pesadao/ouvir.wmx',
    'mms://p.mm.uol.com.br/paradisofm',
    'http://www.radiopagofunk.com.br/aovivo.asx',
    'http://174.36.195.11/~paineldj/centova/tunein.php/brasilmpb/playlist.pls',
    'mms://200.203.124.65/poprock',
    'http://69.162.90.148:7814/listen.pls',
    );
    
implementation

end.

