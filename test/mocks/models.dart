const movieMock = '''{
"id": 86,
"title": "A Day to Die",
"vote_average": 6.3,
"poster_path": "/8Kce1utfytAG5m1PbtVoDzmDZJH.jpg",
"release_date": "2022-03-04"
}''';

const mockPageMovie = {
  "dates": {"maximum": "2022-07-20", "minimum": "2022-06-02"},
  "page": 1,
  "results": mockListMovies,
  "total_pages": 69,
  "total_results": 1372
};

const mockPageMovieWithListMoviesIsEmpty = {
  "dates": {"maximum": "2022-07-20", "minimum": "2022-06-02"},
  "page": 1,
  "results": mockListMoviesIsEmpty,
  "total_pages": 69,
  "total_results": 1372
};

const mockPageMovieNull = null;

const mockPageMovieContractInvaled = {
  "dates": {"maximum": "2022-07-20", "minimum": "2022-06-02"},
  "page": '1', //era pra ser int
  "results": mockListMovies,
  "total_pages": 69,
  "total_results": 1372
};

const mockPageMovieWithContractMovieInvaled = {
  "dates": {"maximum": "2022-07-20", "minimum": "2022-06-02"},
  "page": '1', //era pra ser int
  "results": mockListMoviesContractInvaled,
  "total_pages": 69,
  "total_results": 1372
};

const mockListMovies = [
  {
    "adult": false,
    "backdrop_path": "/tzNx4y7kYf1Xw3F3T6QxrE7PPwb.jpg",
    "genre_ids": [53, 18, 80, 9648, 27],
    "id": 825808,
    "original_language": "en",
    "original_title": "See for Me",
    "overview":
        "When blind former skier Sophie cat-sits in a secluded mansion, three thieves invade for the hidden safe. Sophie's only defense is army veteran Kelly, who she meets on the See For Me app. Kelly helps Sophie defend herself against the invaders and survive.",
    "popularity": 649.77,
    "poster_path": "/qk1ZERG6yhwAJqTobmDgw8jRL2C.jpg",
    "release_date": "2022-01-07",
    "title": "See for Me",
    "video": false,
    "vote_average": 6.3,
    "vote_count": 80
  },
  {
    "adult": false,
    "backdrop_path": "/cugmVwK0N4aAcLibelKN5jWDXSx.jpg",
    "genre_ids": [16, 28, 12, 878],
    "id": 768744,
    "original_language": "ja",
    "original_title": "僕のヒーローアカデミア THE MOVIE ワールド ヒーローズ ミッション",
    "overview":
        "A mysterious group called Humarize strongly believes in the Quirk Singularity Doomsday theory which states that when quirks get mixed further in with future generations, that power will bring forth the end of humanity. In order to save everyone, the Pro-Heroes around the world ask UA Academy heroes-in-training to assist them and form a world-classic selected hero team. It is up to the heroes to save the world and the future of heroes in what is the most dangerous crisis to take place yet in My Hero Academia.",
    "popularity": 625.021,
    "poster_path": "/4NUzcKtYPKkfTwKsLjwNt8nRIXV.jpg",
    "release_date": "2021-08-06",
    "title": "My Hero Academia: World Heroes' Mission",
    "video": false,
    "vote_average": 7.6,
    "vote_count": 217
  },
  {
    "adult": false,
    "backdrop_path": "/sahdgvn0Brw6AgdwyLHgdCAynWG.jpg",
    "genre_ids": [12, 16, 35, 10751, 14],
    "id": 778855,
    "original_language": "en",
    "original_title": "Chickenhare and the Hamster of Darkness",
    "overview":
        "Young Chickenhare is the adopted son of King Peter, a famous adventurer. Part chicken and part hare, he has a really tough time growing up and disguises himself as a hare to avoid the mockeries of his peers. When the day of the Royal Adventurer Society trials comes, Chickenhare, hampered by his disguise, fails miserably. But he is determined to grab a second chance and find the Scepter of the Hamster of Darkness, before his evil Uncle Lapin. The Scepter will give immense power to its holder. If Lapin gets hold of it, he will be unstoppable. Accompanied by his faithful servant Abe, a sarcastic turtle, and Meg, a martial arts expert skunk, he sets of on an epic and initiatory quest.",
    "popularity": 550.833,
    "poster_path": "/2v6f1EqTo4FUxVT9MDXpF6158AX.jpg",
    "release_date": "2022-02-16",
    "title": "Chickenhare and the Hamster of Darkness",
    "video": false,
    "vote_average": 7.6,
    "vote_count": 121
  },
];

const mockListMoviesIsEmpty = [];

const mockListMoviesContractInvaled = [
  {
    "adult": false,
    "backdrop_path": "/tzNx4y7kYf1Xw3F3T6QxrE7PPwb.jpg",
    "genre_ids": [53, 18, 80, 9648, 27],
    "id": '825808', // era pra ser int
    "original_language": "en",
    "original_title": "See for Me",
    "overview":
        "When blind former skier Sophie cat-sits in a secluded mansion, three thieves invade for the hidden safe. Sophie's only defense is army veteran Kelly, who she meets on the See For Me app. Kelly helps Sophie defend herself against the invaders and survive.",
    "popularity": 649.77,
    "poster_path": "/qk1ZERG6yhwAJqTobmDgw8jRL2C.jpg",
    "release_date": "2022-01-07",
    "title": "See for Me",
    "video": false,
    "vote_average": 6.3,
    "vote_count": 80
  }
];
