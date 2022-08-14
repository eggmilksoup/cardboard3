package main
import "fmt"
import "github.com/bwmarrin/discordgo"
import "math/rand"
import "os"
import "time"

// logmentions.go version 3.0.0

func main() {
	if len(os.Args) < 2 {
		fmt.Fprintf(os.Stderr, "usage: %s apikey ...\n", os.Args[0])
		os.Exit(1)
	}
	discord, _ := discordgo.New("Bot " + os.Args[1])
	discord.Open()
	discord.UpdateGameStatus(0, "not currently polling.")
	discord.AddHandler( func(discord *discordgo.Session, event *discordgo.MessageCreate) {
		for _, usr := range event.Message.Mentions {
			me, _ := discord.User("@me")
			if usr.ID == me.ID {
				fmt.Printf("%s:%s:%s\n", event.Message.ChannelID, event.Message.ID, event.Message.Content)
			}
		}
	})
	hours, _ := time.ParseDuration(fmt.Sprintf("%dh%dm", rand.Intn(67) + 6, rand.Intn(60)))
	time.Sleep(hours)
}