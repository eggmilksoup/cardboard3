// status.go version 3.0.0

package main
import "fmt"
import "github.com/bwmarrin/discordgo"
import "os"
import "time"

func main() {
	if len(os.Args) < 3 {
		fmt.Fprintf(os.Stderr, "usage: %s apikey message\n", os.Args[0])
		os.Exit(1)
	}
	discord, _ := discordgo.New("Bot " + os.Args[1])
	discord.Open()
	discord.UpdateGameStatus(0, os.Args[2])
	qtr, _ := time.ParseDuration("15m")
	time.Sleep(qtr)
}
