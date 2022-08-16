// pullrcp.go version 3.1.0

package main
import "fmt"
import "github.com/bwmarrin/discordgo"
import "os"

func main() {
        if len(os.Args) < 4 {
		fmt.Fprintf(os.Stderr, "usage: %s apikey channel messageid ...\n", os.Args[0])
		os.Exit(1)
	}
	discord, _ := discordgo.New("Bot " + os.Args[1])
	txt := ""
	for i:= 3; i < len(os.Args); i ++ {
		msg, _ := discord.ChannelMessage(os.Args[2], os.Args[i])
		txt = txt + msg.Content + "\n"
	}
	fmt.Println(txt)
}
