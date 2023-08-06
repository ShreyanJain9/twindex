package main

import (
	"fmt"
	"path/filepath"
	"time"

	"gorm.io/driver/sqlite"
	"gorm.io/gorm"
)

var db *gorm.DB

type Twts struct {
	ID        uint `gorm:"primaryKey"`
	CreatedAt time.Time
	Content   string
	Original  string
	ReplyTo   string
	Hash      string `gorm:"unique"`
	FeedID    uint
}

type Feeds struct {
	ID       uint `gorm:"primaryKey"`
	Nick     string
	URL      string `gorm:"unique"`
	Avatar   string
	SyncedAt time.Time
}

type Mentions struct {
	ID     uint `gorm:"primaryKey"`
	FeedID uint
	TwtID  uint
}

type Follows struct {
	ID          uint `gorm:"primaryKey"`
	FollowerID  uint
	FollowingID uint
}

func setup() {
	db.AutoMigrate(&Twts{}, &Feeds{}, &Mentions{}, &Follows{})
}

func main() {
	var err error
	db, err = gorm.Open(sqlite.Open(filepath.Join(".", "twindex.db")), &gorm.Config{})
	if err != nil {
		fmt.Println("Error connecting to the database:", err)
		return
	}
	sqlDB, err := db.DB()
	if err != nil {
		fmt.Println("Error getting DB connection:", err)
		return
	}
	defer sqlDB.Close()

	setup()
}
