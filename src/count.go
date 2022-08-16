// count.go version 3.1.0

package main
import "fmt"
import "github.com/bwmarrin/discordgo"
import "os"

func main() {
	if len(os.Args) < 5 {
		fmt.Fprintf(os.Stderr, "usage: %s apikey channel message ( y | n )\n", os.Args[0])
		os.Exit(1)
	}
	discord, _ := discordgo.New("Bot " + os.Args[1])
	var votes []*discordgo.User
	switch os.Args[4] {
		case "y":
			votes, _ = discord.MessageReactions(os.Args[2], os.Args[3], "✅", 100, "", "")
		case "n":
			votes, _ = discord.MessageReactions(os.Args[2], os.Args[3], "❌", 100, "", "")
		default:
			fmt.Fprintf(os.Stderr, "usage: %s apikey channel message ( y | n )\n", os.Args[0])
			os.Exit(1)
	}
	fmt.Printf("%d\n", len(votes))
}
