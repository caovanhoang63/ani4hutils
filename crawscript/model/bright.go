package model

type FilmCharacterActor struct {
	FilmCharacterId int
	ActorId         int
}

type FilmStudio struct {
	FilmId   int
	StudioId int
}

type FilmProducer struct {
	FilmId     int
	ProducerId int
}

type FilmFilmCharacter struct {
	FilmId      int
	CharacterId int `json:"CharacterId" gorm:"column:film_character_id"`
}

type FilmGenre struct {
	FilmId  int
	GenreId int
}
