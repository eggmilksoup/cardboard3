// logdms.go version 3.1.0

package main
import "fmt"
import "github.com/bwmarrin/discordgo"
import "os"
import "time"

func main() {
	if len(os.Args) < 3 {
		fmt.Fprintf(os.Stderr, "usage: %s apikey admin ...\n", os.Args[0])
		os.Exit(1)
	}
	discord, _ := discordgo.New("Bot " + os.Args[1])
	discord.Open()
	discord.UpdateGameStatus(0, "not currently polling.")
	discord.AddHandler( func(discord *discordgo.Session, event *discordgo.MessageCreate) {
		if event.Message.GuildID == "" {
			for i := 2; i < len(os.Args); i ++ {
				if os.Args[i] == event.Message.Author.ID {
					fmt.Printf("%s:%s:%s\n", event.Message.ChannelID, event.Message.ID, event.Message.Content)
					break
				}
			}
		}
	})
	two, _ := time.ParseDuration("48h")
	time.Sleep(two)
}
