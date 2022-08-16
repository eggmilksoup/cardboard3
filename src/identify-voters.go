// identify-voters.go version 3.1.0/303

package main
import "fmt"
import "github.com/bwmarrin/discordgo"
import "os"

func main() {
	if len(os.Args) < 4 {
		fmt.Fprintf(os.Stderr, "usage: %s apikey channel message [ y | n | 1 | 2 | ... | 10 ]\n", os.Args[0])
		os.Exit(1)
	}
	discord, _ := discordgo.New("Bot " + os.Args[1])
	var votes []*discordgo.User
	switch os.Args[4] {
		case "y":
			votes, _ = discord.MessageReactions(os.Args[2], os.Args[3], "✅", 100, "", "")
		case "n":
			votes, _ = discord.MessageReactions(os.Args[2], os.Args[3], "❌", 100, "", "")
		case "1":
			votes, _ = discord.MessageReactions(os.Args[2], os.Args[3], "🐦", 100, "", "")
		case "2":
			votes, _ = discord.MessageReactions(os.Args[2], os.Args[3], "🐦", 100, "", "")
		case "3":
			votes, _ = discord.MessageReactions(os.Args[2], os.Args[3], "🐱", 100, "", "")
		case "4":
			votes, _ = discord.MessageReactions(os.Args[2], os.Args[3], "🧃", 100, "", "")
		case "5":
			votes, _ = discord.MessageReactions(os.Args[2], os.Args[3], "🦹‍♂️", 100, "", "")
		case "6":
			votes, _ = discord.MessageReactions(os.Args[2], os.Args[3], "🧞‍♂️", 100, "", "")
		case "7":
			votes, _ = discord.MessageReactions(os.Args[2], os.Args[3], "⚔️", 100, "", "")
		case "8":
			votes, _ = discord.MessageReactions(os.Args[2], os.Args[3], "🐲", 100, "", "")
		case "9":
			votes, _ = discord.MessageReactions(os.Args[2], os.Args[3], "💾", 100, "", "")
		case "10":
			votes, _ = discord.MessageReactions(os.Args[2], os.Args[3], "😈", 100, "", "")
		default:
			fmt.Fprintf(os.Stderr, "usage: %s apikey channel message [ y | n | 1 | 2 | ... | 10 ]\n", os.Args[0])
			os.Exit(1)
	}
	for _, usr := range votes {
		fmt.Println(usr.ID)
	}
}
