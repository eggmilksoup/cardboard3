// nickname.go version 3.1.0

package main
import "fmt"
import "github.com/bwmarrin/discordgo"
import "os"

func main() {
	if len(os.Args) < 3 {
		fmt.Fprintf(os.Stderr, "usage: %s apikey nickname\n", os.Args[0])
		os.Exit(1)
	}
	discord, _ := discordgo.New("Bot " + os.Args[1])
	discord.UpdateGameStatus(0, os.Args[2])
	discord.GuildMemberNickname("478329250349449216", "@me", os.Args[2])
}
