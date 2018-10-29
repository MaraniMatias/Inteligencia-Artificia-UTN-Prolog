<template>
<div>
  <beautiful-chat
    :participants="participants"
    :titleImageUrl="titleImageUrl"
    :onMessageWasSent="onMessageWasSent"
    :messageList="messageList"
    :newMessagesCount="newMessagesCount"
    :isOpen="isChatOpen"
    :close="closeChat"
    :open="openChat"
    :showEmoji="false"
    :showFile="false"
    :showTypingIndicator="showTypingIndicator"
    :colors="colors"
    :alwaysScrollToBottom="alwaysScrollToBottom" />
</div>
</template>

<script>
import axios from 'axios';

const URL_BASE = 'http://localhost:8008';

export default {
  name: 'app',
  data() {
    return {
      participants: [
        {
          id: 'AlergiaSam',
          name: 'AlergiaSam',
          imageUrl: 'https://avatars3.githubusercontent.com/u/1915989?s=230&v=4',
        },
      ],
      // the list of all the participant of the conversation.
      // `name` is the user name, `id` is used to establish the author of a message,
      // `imageUrl` is supposed to be the user avatar.
      titleImageUrl: 'https://a.slack-edge.com/66f9/img/avatars-teams/ava_0001-34.png',
      messageList: [
        { type: 'text', author: 'AlergiaSam', data: { text: 'No.' } },
      ], // the list of the messages to show, can be paginated and adjusted dynamically
      newMessagesCount: 0,
      isChatOpen: true,
      showTypingIndicator: '', // when set to a value matching the participant.id it shows the typing indicator for the specific user
      // when set to true always scrolls the chat to the bottom
      // when new events are in (new message, user starts typing...)
      colors: {
        header: {
          bg: '#4e8cff',
          text: '#ffffff',
        },
        launcher: {
          bg: '#4e8cff',
        },
        messageList: {
          bg: '#ffffff',
        },
        sentMessage: {
          bg: '#4e8cff',
          text: '#ffffff',
        },
        receivedMessage: {
          bg: '#eaeaea',
          text: '#222222',
        },
        userInput: {
          bg: '#f4f7f9',
          text: '#565867',
        },
      }, // specifies the color scheme for the component
      alwaysScrollToBottom: false,
    };
  },
  methods: {
    sendMessage(text) {
      if (text.length > 0) {
        this.newMessagesCount = this.isChatOpen ?
          this.newMessagesCount :
          this.newMessagesCount + 1;
        this.onMessageWasSent({
          author: 'support',
          type: 'text',
          data: { text },
        });
      }
    },
    onMessageWasSent(message) {
      // called when the user sends a message
      this.messageList = [...this.messageList, message];
    },
    openChat() {
      // called when the user clicks on the fab button to open the chat
      this.isChatOpen = true;
      this.newMessagesCount = 0;
    },
    closeChat() {
      // called when the user clicks on the botton to close the chat
      this.isChatOpen = false;
    },
  },
  created() {
    axios.get(`${URL_BASE}/hello/matias`)
      .then((response) => {
        // handle success
        console.log(response.data);
      })
      .catch((error) => {
        // handle error
        console.log(error);
      })
      .then(() => {
        // always executed
      });
  },
};
</script>

<style>

</style>
