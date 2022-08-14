package main
import "fmt"
import "github.com/bwmarrin/discordgo"
import "os"

// mention.go version 3.0.0

func main() {
	if len(os.Args) < 3 {
		fmt.Fprintf(os.Stderr, "usage: %s apikey userid\n", os.Args[0])
		os.Exit(1)
	}
	discord, _ := discordgo.New("Bot " + os.Args[1])
	usr, _ := discord.User(os.Args[2])
	fmt.Println(usr.Username)
}
