// emojicat.go version 3.1.0/303

package main
import "fmt"
import "github.com/bwmarrin/discordgo"
import "os"
import "time"

func main() {
	if len(os.Args) < 3 {
		fmt.Fprintf(os.Stderr, "usage: %s apikey messageid", os.Args[0])
		os.Exit(1)
	}
	discord, _ := discordgo.New("Bot " + os.Args[1])
	discord.Open()
	discord.UpdateGameStatus(0, "polls are open!")
	discord.AddHandler( func(discord *discordgo.Session, event *discordgo.MessageReactionAdd) {
		if os.Args[2] == event.MessageReaction.MessageID {
			fmt.Println(event.MessageReaction.Emoji.Name)
		}
	})
	two, _ := time.ParseDuration("48h")
	time.Sleep(two)
}
