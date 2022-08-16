// logmentions.go version 3.0.0

package main
import "fmt"
import "github.com/bwmarrin/discordgo"
import "math/rand"
import "os"
import "time"

func main() {
	if len(os.Args) < 2 {
		fmt.Fprintf(os.Stderr, "usage: %s apikey\n", os.Args[0])
		os.Exit(1)
	}
	discord, _ := discordgo.New("Bot " + os.Args[1])
	discord.Open()
	discord.UpdateGameStatus(0, "always learning, ever growing")
	discord.AddHandler( func(discord *discordgo.Session, event *discordgo.MessageCreate) {
		for _, usr := range event.Message.Mentions {
			me, _ := discord.User("@me")
			if usr.ID == me.ID {
				fmt.Printf("%s:%s:%s\n", event.Message.ChannelID, event.Message.ID, event.Message.Content)
			}
		}
	})
	hours, _ := time.ParseDuration(fmt.Sprintf("%dh%dm", rand.Intn(66) + 6, rand.Intn(60)))
	time.Sleep(hours)
	discord.UpdateGameStatus(0, "collecting eldritch data")
}
