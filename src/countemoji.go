// countemoji.go version 3.1.0/303

package main
import "fmt"
import "github.com/bwmarrin/discordgo"
import "os"

func main() {
	if len(os.Args) < 5 {
		fmt.Fprintf(os.Stderr, "usage: %s apikey channel message emoji\n", os.Args[0])
		os.Exit(1)
	}
	discord, _ := discordgo.New("Bot " + os.Args[1])
	votes, _ := discord.MessageReactions(os.Args[2], os.Args[3], os.Args[4], 100, "", "")
	fmt.Printf("%d\n", len(votes))
}
