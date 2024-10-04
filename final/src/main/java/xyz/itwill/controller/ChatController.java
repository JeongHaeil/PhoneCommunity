package xyz.itwill.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dto.Chat;
import xyz.itwill.dto.ChatRooms;
import xyz.itwill.service.ChatMessageService;
import xyz.itwill.service.ChatRoomsService;
import xyz.itwill.service.ChatService;


@Controller
@RequiredArgsConstructor
@RequestMapping("/chat")
public class ChatController {

	private final ChatService chatService;
	private final ChatMessageService chatMessageService;
	private final ChatRoomsService chatRoomsService;
	
	
	
	@PostMapping("/send")
    public String sendChat(@ModelAttribute Chat chat) {
        chatService.insertChat(chat);
        return "redirect:/chat/view?productId=" + chat.getProductId();
    }

    @GetMapping("/view")
    public String viewChat(@RequestParam int productId, Model model) {
        List<Chat> chatList = chatService.getChatByProductId(productId);
        model.addAttribute("chatList", chatList);
        return "chat/view";
    }

    @PostMapping("/chatroom/create")
    public String createChatRoom(@ModelAttribute ChatRooms chatRooms) {
        chatRoomsService.createChatRooms(chatRooms);
        return "redirect:/chatroom/view?roomId=" + chatRooms.getRoomId();
    }

    @GetMapping("/chatroom/view")
    public String viewChatRoom(@RequestParam int sellerId,@RequestParam int buyerId, Model model) {
        ChatRooms chatRooms = chatRoomsService.getChatRooms(sellerId, buyerId);
        model.addAttribute("chatRooms", chatRooms);
        return "chatroom/view";
    }
	
}
