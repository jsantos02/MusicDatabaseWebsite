import warnings
warnings.filterwarnings("ignore", category=FutureWarning)
from flask import abort, render_template, Flask
import logging
import db

APP = Flask(__name__)

# Start page
@APP.route('/')
def index():
    stats = {}
    x = db.execute('SELECT COUNT(*) AS users FROM USER').fetchone()
    stats.update(x)
    x = db.execute('SELECT COUNT(*) AS tracks FROM TRACK').fetchone()
    stats.update(x)
    x = db.execute('SELECT COUNT(*) AS artists FROM ARTIST').fetchone()
    stats.update(x)    
    x = db.execute('SELECT COUNT(*) AS albums FROM ALBUM').fetchone()
    stats.update(x)
    logging.info(stats)
    return render_template('index.html',stats=stats)

# Initialize db
# It assumes a script called db.sql is stored in the sql folder
@APP.route('/init/')
def init(): 
    return render_template('init.html', init=db.init())
# Albums
@APP.route('/albums/')
def list_albums():
    albums = db.execute(
        '''
        SELECT Album_ID, Album_Title,Art_Name,COUNT(Track_ID) AS NumberOfTracks ,SEC_TO_TIME(SUM(TIME_TO_SEC(Track_RT))) AS Duration, Album_RD AS ReleaseDate, Art_ID
        FROM ALBUM JOIN TRACK ON (ALBUM.Album_ID = TRACK.TRAlbum_ID) JOIN ARTIST ON (ALBUM.AlbumArt_ID = ARTIST.Art_ID)        
        GROUP BY Album_Title, Album_RD, Album_ID, AlbumArt_ID, Art_ID          
        ORDER BY Album_Title, Art_Name
        ''').fetchall()
    return render_template('album-list.html', albums=albums)

@APP.route('/albums/<id>/')
def get_album(id):
    albums = db.execute(
      '''
        SELECT Album_ID, Album_Title,Art_Name AS Artist,COUNT(Track_ID) AS NumberOfTracks ,SEC_TO_TIME(SUM(TIME_TO_SEC(Track_RT))) AS Duration, Album_RD AS ReleaseDate
        FROM ALBUM JOIN TRACK ON (ALBUM.Album_ID = TRACK.TRAlbum_ID) JOIN ARTIST ON (ALBUM.AlbumArt_ID = ARTIST.Art_ID)        
        WHERE Album_ID = %s
        GROUP BY Album_Title, Album_RD, Album_ID, AlbumArt_ID          
        ORDER BY Album_Title, Art_Name
      ''', id).fetchone()

    if albums is None:
        abort(404, 'Album id {} does not exist.'.format(id))

    artist = db.execute(
        '''
        SELECT Art_ID, Art_Name, AlbumArt_ID
        FROM ARTIST JOIN ALBUM ON(ARTIST.Art_ID = ALBUM.AlbumArt_ID)
        WHERE Album_ID = %s
        ORDER BY Art_ID
        ''',id).fetchone()

    genres = db.execute(
        '''
        SELECT Album_ID, Album, Genre
        FROM ALBUM JOIN GENRE_ALBUM ON (ALBUM.Num = GENRE_ALBUM.Album)
        WHERE Album_ID = %s
        GROUP BY Genre, Album, Album_ID
        ORDER BY Genre
        ''',id).fetchall()

    tracks = db.execute(
        '''
        SELECT Track_Title AS Title, TrAlbum_ID, Track_ID
        FROM ALBUM JOIN TRACK ON (ALBUM.Album_ID = TRACK.TrAlbum_ID)
        WHERE Album_ID = %s
        GROUP BY Track_Title, TrAlbum_ID, Track_ID
        ORDER BY Track_ID   
        ''',id).fetchall()
    
    users = db.execute(
        '''
        SELECT User, Album, Login, Album_ID
        FROM LIKE_ALBUM JOIN ALBUM ON (LIKE_ALBUM.Album = ALBUM.Num) JOIN USER on (LIKE_ALBUM.User = USER.Num)
        WHERE Album_ID = %s
        ORDER BY Login
        ''',id).fetchall()
    return render_template('album.html', albums=albums,users=users,tracks=tracks,genres=genres,artist=artist)
#Search for Albums
@APP.route('/albums/search/<expr>/')
def search_album(expr):
  search = { 'expr': expr }
  expr = '%' + expr + '%'
  albums = db.execute(
      ''' 
      SELECT Album_ID, Album_Title
      FROM ALBUM 
      WHERE Album_Title LIKE %s
      ''', expr).fetchall()
  return render_template('album-search.html',
           search=search,albums=albums)

#Artists

@APP.route('/artists/')
def list_artists():
    artists = db.execute(
        '''
        SELECT Art_ID, Art_Name,Art_BirthDate,Art_Sex,Art_Country
        FROM ARTIST
        ORDER BY Art_Name
        ''' 
    ).fetchall()
    return render_template('artists-list.html', artists=artists)

@APP.route('/artists/<id>/')
def view_albums_by_artist(id):
    artist = db.execute(
        '''
        SELECT Art_ID, Art_Name, Art_BirthDate, Art_Sex, Art_Country
        FROM ARTIST 
        WHERE Art_ID = %s
        ''', id).fetchone()

    if artist is None:
     abort(404, 'Artist id {} does not exist.'.format(id))

    albums = db.execute(
        '''
        SELECT AlbumArt_ID, Album_Title, Album_ID
        FROM ALBUM JOIN ARTIST ON (ALBUM.AlbumArt_ID = ARTIST.Art_ID)
        WHERE Art_ID = %s
        GROUP BY AlbumArt_ID, Album_Title, Album_ID
        ''',id
    ).fetchall()

    genresart = db.execute(
        '''
        SELECT Art_ID, Artist, Genre AS GenreArt
        FROM ARTIST JOIN GENRE_ARTIST ON (ARTIST.Num = GENRE_ARTIST.Artist)
        WHERE Art_ID = %s
        GROUP BY Genre, Artist, Art_ID
        ORDER BY Genre
        ''',id).fetchall()
    tracks = db.execute(
        '''
        SELECT Track_Title, Artist_ID, TrAlbum_ID, Track_ID
        FROM TRACK 
        WHERE TrAlbum_ID IS NULL AND Artist_ID = %s
        ''',id).fetchall()
    users = db.execute(
        '''
        SELECT User, Artista, Login, Art_ID
        FROM FOLLOW_ARTIST JOIN ARTIST ON (FOLLOW_ARTIST.Artista = ARTIST.Num) JOIN USER ON (FOLLOW_ARTIST.User = USER.Num)
        WHERE Art_ID = %s
        ORDER BY Login
        ''',id).fetchall()
    return render_template('artist.html', artist=artist, albums=albums,genresart=genresart,tracks=tracks,users=users)
@APP.route('/artists/search/<expr>/')
def search_artist(expr):
  search = { 'expr': expr }
  expr = '%' + expr + '%'
  artists = db.execute(
      ''' 
      SELECT Art_ID, Art_Name
      FROM ARTIST 
      WHERE Art_Name LIKE %s
      ''', expr).fetchall()
  return render_template('artist-search.html',
           search=search,artists=artists)

# Tracks
@APP.route('/tracks/')
def list_tracks():
    tracks = db.execute(
        '''
        SELECT Track_ID, Track_Title AS Title, Art_Name, Album_Title, Track_Plays AS TotalPlays, Track_RT AS Runtime, Art_ID, Album_ID
        FROM TRACK LEFT JOIN ALBUM ON (TRACK.TRAlbum_ID = ALBUM.Album_ID) JOIN ARTIST ON (TRACK.Artist_ID = ARTIST.Art_ID)
        GROUP BY Track_ID, Track_Title, Track_Plays, Track_RT, Art_ID, Album_ID
        ORDER BY Art_Name, Album_Title, Track_ID
        '''
    ).fetchall()
    return render_template('tracks-list.html', tracks=tracks)
@APP.route('/tracks/<id>/')
def get_track(id):
    track = db.execute(
        '''
        SELECT Track_ID, Track_Title, Track_RT, Track_Plays
        FROM TRACK 
        WHERE Track_ID = %s
        ''', id).fetchone()

    if track is None:
     abort(404, 'Track id {} does not exist.'.format(id))

    albums = db.execute(
        '''
        SELECT TrAlbum_ID, Album_Title, Album_ID
        FROM TRACK JOIN ALBUM ON (TRACK.TrAlbum_ID = ALBUM.Album_ID)
        WHERE Track_ID = %s
        GROUP BY TrAlbum_ID, Album_Title, Album_ID
        ''',id
    ).fetchone()

    artists = db.execute(
        '''
        SELECT Art_ID, Artist_ID, Art_Name
        FROM TRACK JOIN ARTIST ON (TRACK.Artist_ID=ARTIST.Art_ID)
        WHERE Track_ID = %s
        GROUP BY Art_ID, Artist_ID, Art_Name
        ''',id
    ).fetchone()

    playlists = db.execute(
        '''
        SELECT Track_ID, IDTrack, Play_ID, IDPlaylist, Play_Title
        FROM PLAYLIST_TEST JOIN TRACK ON (PLAYLIST_TEST.IDTrack = TRACK.Track_ID) JOIN PLAYLIST ON (PLAYLIST_TEST.IDPlaylist = PLAYLIST.Play_ID)
        WHERE Track_ID = %s
        GROUP BY Track_ID, IDTrack, Play_ID, IDPlaylist, Play_Title
        ''',id
    ).fetchall()

    genrestrack = db.execute(
        '''
        SELECT Track_ID, Track, Genre AS GenreTr
        FROM TRACK JOIN GENRE_TRACK ON (TRACK.Num = GENRE_TRACK.Track)
        WHERE Track_ID = %s
        GROUP BY Track_ID, Track, Genre
        ORDER BY Genre
        ''',id
    ).fetchall()
    return render_template('track.html',track=track,genrestrack=genrestrack,playlists=playlists,albums=albums,artists=artists)
@APP.route('/tracks/search/<expr>/')
def search_track(expr):
  search = { 'expr': expr }
  expr = '%' + expr + '%'
  tracks = db.execute(
      ''' 
      SELECT Track_ID, Track_Title
      FROM TRACK 
      WHERE Track_Title LIKE %s
      ''', expr).fetchall()
  return render_template('track-search.html',
           search=search,tracks=tracks)
# Users
@APP.route('/users/')
def list_users():
    users = db.execute(
        '''
        SELECT Login,Name, BirthDate, Sex, Phone, Email, Plan, Joined
        FROM USER
        ORDER BY Login
        '''
    ).fetchall()
    return render_template('users-list.html',users=users)
@APP.route('/users/<id>/')
def get_user(id):
    user = db.execute(
        '''
        SELECT Login, Name, Joined, BirthDate,Sex,Phone,Email, Plan
        FROM USER
        WHERE Login = %s
        ORDER BY Login
        ''',id).fetchone()
    
    if user is None:
     abort(404, 'User ID {} does not exist.'.format(id))

    playlists = db.execute(
        '''
        SELECT Play_ID, Play_User, Login, Play_Title
        FROM PLAYLIST JOIN USER ON (PLAYLIST.Play_User = USER.Login)
        WHERE Login = %s
        ORDER BY Play_Title
        ''',id
    ).fetchall()

    followplaylists = db.execute(
        '''
        SELECT Play_ID, Play_User, Login, Play_Title, User, Playlist
        FROM FOLLOW_PLAYLIST JOIN USER ON (FOLLOW_PLAYLIST.User = USER.Num) JOIN PLAYLIST ON(FOLLOW_PLAYLIST.Playlist = PLAYLIST.Num)
        WHERE Login = %s
        ORDER BY Play_Title
        ''',id
    ).fetchall()

    followartists = db.execute(
        '''
        SELECT User, Artista, Login, Art_ID, Art_Name
        FROM FOLLOW_ARTIST JOIN USER ON (FOLLOW_ARTIST.User = USER.Num) JOIN ARTIST ON (FOLLOW_ARTIST.Artista = ARTIST.Num)
        WHERE Login = %s
        ORDER BY Art_Name
        ''',id).fetchall()

    albumsliked = db.execute(
        '''
        SELECT User, Album, Login, Album_ID, Album_Title
        FROM LIKE_ALBUM JOIN USER ON (LIKE_ALBUM.User = USER.Num) JOIN ALBUM ON (LIKE_ALBUM.Album = ALBUM.Num)
        WHERE Login = %s
        ORDER BY Album_Title
        ''',id
    ).fetchall()
    follows = db.execute(
        '''
        SELECT User, Follower, S1.Login AS Following,S2.Login 
        FROM FOLLOWER JOIN USER S1 ON (FOLLOWER.User = S1.Num) JOIN USER S2 ON (FOLLOWER.Follower = S2.Num) 
        WHERE S1.Login = %s
        ''',id
    ).fetchall() # TENHO DE TRABALHAR ISTO
    followed = db.execute(
        '''
        SELECT User, Follower, S1.Login AS Following,S2.Login 
        FROM FOLLOWER JOIN USER S1 ON (FOLLOWER.Follower = S1.Num) JOIN USER S2 ON (FOLLOWER.User = S2.Num) 
        WHERE S1.Login = %s
        ''',id
    ).fetchall()
    return render_template('user.html', user=user,follows=follows,followed=followed,followartists=followartists,playlists=playlists,followplaylists=followplaylists,albumsliked=albumsliked)

@APP.route('/playlists/')
def list_playlists():
    playlists = db.execute(
        '''
        SELECT Play_ID, Play_Title, Play_User, Login
        FROM PLAYLIST JOIN USER ON (PLAYLIST.Play_User = USER.Login)
        ORDER BY Play_ID
        '''
    ).fetchall()
    return render_template('playlists-list.html',playlists=playlists)

@APP.route('/playlists/<id>/')
def get_playlist(id):
    playlist = db.execute(
        '''
        SELECT Play_ID, Play_Title, Play_User, Play_Desc
        FROM PLAYLIST
        WHERE Play_ID = %s
        ''',id
    ).fetchone()
    if playlist is None:
     abort(404, 'Playlist id {} does not exist.'.format(id))

    duration = db.execute(
        '''
        SELECT Play_ID, Play_Title, IDPlaylist,COUNT(IDTrack) AS Counter, SEC_TO_TIME(SUM(TIME_TO_SEC(Track_RT))) AS Duration 
        FROM PLAYLIST_TEST JOIN PLAYLIST ON (PLAYLIST_TEST.IDPlaylist = PLAYLIST.Play_ID) JOIN TRACK ON (PLAYLIST_TEST.IDTrack = TRACK.Track_ID)
        WHERE Play_ID = %s 
        GROUP BY Play_ID, Play_Title, IDPlaylist;
        ''',id
    ).fetchone()

    tracks = db.execute(
        '''
        SELECT Play_ID, IDTrack, Track_ID, Track_Title, IDPlaylist
        FROM PLAYLIST_TEST JOIN PLAYLIST ON (PLAYLIST_TEST.IDPlaylist = PLAYLIST.Play_ID) JOIN TRACK ON(PLAYLIST_TEST.IDTrack = TRACK.Track_ID)
        WHERE Play_ID = %s
        ''',id
    ).fetchall()

    following = db.execute(
        '''
        SELECT Play_ID, Play_User, Login, User, Playlist
        FROM FOLLOW_PLAYLIST JOIN USER ON (FOLLOW_PLAYLIST.User = USER.Num) JOIN PLAYLIST ON (FOLLOW_PLAYLIST.Playlist = PLAYLIST.Num)
        WHERE Play_ID = %s
        ORDER BY Login
        ''',id
    ).fetchall()
    return render_template('playlists.html',following=following,tracks=tracks,playlist=playlist,duration=duration)
# TODO
# Página artists incompleta(FALTA INFORMAÇÃO DELES).