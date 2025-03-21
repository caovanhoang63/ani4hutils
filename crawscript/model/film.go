package model

type Film struct {
	Id                         int               `json:"id" gorm:"column:id"`
	Title                      string            `json:"title" gorm:"column:title"`
	AlternativeTitles          AlternativeTitles `json:"alternativeTitles"`
	Images                     []string          `json:"images"`
	ImageObject                *Images           `json:"imageObjects" gorm:"column:images"`
	Synopsis                   string            `json:"synopsis"`
	StartDate                  string            `json:"startDate"`
	Aired                      string            `json:"aired"`
	EndDate                    *string           `json:"endDate"`
	MaxEpisodes                int               `json:"maxEpisodes"`
	NumEpisodes                int               `json:"numEpisodes"`
	Genres                     []string          `json:"genres"`
	GenreObjects               []Genre           `json:"genreObjects"`
	AgeRating                  string            `json:"ageRating"`
	Background                 string            `json:"background"`
	State                      string            `json:"state"`
	AverageEpisodeDuration     int               `json:"averageEpisodeDuration"`
	TextAverageEpisodeDuration string            `json:"textAverageEpisodeDuration"`
	Studios                    []string          `json:"studios" gorm:"-"`
	StudioObjects              []Studio          `json:"studioObjects" gorm:""`
	Producers                  []string          `json:"producers" gorm:"-"`
	ProducerObjets             []Producer        `json:"producerObjets" gorm:""`
	Season                     string            `json:"season"`
	Broadcast                  *Broadcast        `json:"broadcast"`
	Characters                 []Character       `json:"characters"`
}

func (f *Film) TableName() string {
	return "films"
}

type AlternativeTitles struct {
	Synonyms []string `json:"synonyms"`
	EnName   *string  `json:"enName"`
	JpName   string   `json:"jpName"`
}

func (f *AlternativeTitles) TableName() string {
	return "alternative_titles"
}

type Broadcast struct {
	StartTime string `json:"startTime"`
	DayOfWeek string `json:"dayOfWeek"`
	TimeZone  string `json:"timeZone"`
}

func (f *Broadcast) TableName() string {
	return "broadcasts"
}

type Character struct {
	Name        string       `json:"name"`
	Role        string       `json:"role"`
	Image       string       `json:"image"`
	VoiceActors []VoiceActor `json:"voiceActors"`
}

func (c *Character) TableName() string {
	return "film_characters"
}

type VoiceActor struct {
	Name     string `json:"name"`
	Language string `json:"language"`
	Image    string `json:"image"`
}

func (v *VoiceActor) TableName() string {
	return "actors"
}

type Studio struct {
	Id          int    `json:"id"`
	Name        string `json:"name"`
	Image       *Image `json:"image"`
	Description string `json:"description"`
}

func (*Studio) TableName() string {
	return "studios"
}

type Producer struct {
	Id          int    `json:"id"`
	Name        string `json:"name"`
	Image       *Image `json:"image"`
	Description string `json:"description"`
}

func (*Producer) TableName() string {
	return "producer"
}

type Genre struct {
	Id          int    `json:"id"`
	Name        string `json:"name"`
	Image       *Image `json:"image"`
	Description string `json:"description"`
}

func (*Genre) TableName() string {
	return "genres"
}
