package main
import "fmt"
import "github.com/bwmarrin/discordgo"
import "os"

// msg.go version 3.0.0

func main() {
	if len(os.Args) < 3 {
		fmt.Fprintf(os.Stderr, "usage: %s apikey channel [message]\n", os.Args[0])
		os.Exit(1)
	}
	if len(os.Args) == 3 {
		bin, _ := os.Readfile(os.Stdin)
		txt := string(bin)
	} else {
		txt := ""
		for i := 3; i < len(os.Args); i ++ {
			txt = txt + os.Args[i] + " "
		}
	}
	var messages []string
	discord, _ := discordgo.New("Bot " + os.Args[1])
	if len(txt) >= 2000 {
		for len(txt) >= 1994 {
			var i int
			for i = 1992; i > 1; i -- {
				if txt[i] == '\n' {
					break
				}
			}
			if i == 1 {
				for i = 1992; i > 1; i -- { 
					if txt[i] == ' ' {
						break
					}
				}
				if i == 1 {
					i = 1992
				}
			}
			messages = append(messages, txt[0:i])
			txt = txt[i:len(txt)]
		}
		for i := 0; i < len(messages); i ++ {
			discord.ChannelMessageSend(os.Args[2], fmt.Sprintf("[%d/%d]\n", i + 1, len(messages) + 1) + messages[i])
		}
		msg, _ := discord.ChannelMessageSend(os.Args[2], fmt.Sprintf("[%d/%d]\n", len(messages) + 1, len(messages) + 1) + txt)
	} else {
		msg, _ := discord.ChannelMessageSend(os.Args[2], txt)
	}
	fmt.Println(msg.ID)
}
