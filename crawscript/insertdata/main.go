package main

import (
	"encoding/json"
	"fmt"
	"github.com/caovanhoang63/ani4hutils/crawscript/model"
	_ "gorm.io/driver/mysql"
	"log"
	"os"
)

func main() {
	var films []model.Film
	fileName := fmt.Sprintf("../data/56000-59599.json")
	plan, _ := os.ReadFile(fileName)
	var data []model.Film
	err := json.Unmarshal(plan, &data)
	if err != nil {
		log.Print(err)
	} else {
		films = append(films, data...)
	}
	log.Print(fileName)
	log.Println("total: ", len(films))
	//_, err := gorm.Open(mysql.Open(os.Getenv("DATABASE_URL")))
	//if err != nil {
	//	log.Fatalln(err)
	//} else {
	//	log.Print("Connect database success")
	//}
}
