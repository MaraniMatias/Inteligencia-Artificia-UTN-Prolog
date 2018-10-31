webpackJsonp([1], {
  "0C6+": function (e, t, s) {
    "use strict";
    var i = {
      render: function () {
        var e = this,
          t = e.$createElement,
          s = e._self._c || t;
        return s("div", {
          staticClass: "sc-message--text",
          style: e.messageColors
        }, [s("p", {
          domProps: {
            innerHTML: e._s(e.messageText)
          }
        }), e._v(" "), e.data.meta ? s("p", {
          staticClass: "sc-message--meta",
          style: {
            color: e.messageColors.color
          }
        }, [e._v(e._s(e.data.meta))]) : e._e()])
      },
      staticRenderFns: []
    };
    t.a = i
  },
  "3+o7": function (e, t, s) {
    "use strict";
    Object.defineProperty(t, "__esModule", {
      value: !0
    }), t.default = {
      props: {
        participants: {
          type: Array,
          required: !0
        }
      }
    }
  },
  "3ab+": function (e, t, s) {
    "use strict";
    Object.defineProperty(t, "__esModule", {
      value: !0
    });
    var i = a(s("GFtH")),
      n = a(s("Yqsd"));

    function a(e) {
      return e && e.__esModule ? e : {
        default: e
      }
    }
    t.default = {
      props: {
        data: {
          type: Object,
          required: !0
        },
        messageColors: {
          type: Object,
          required: !0
        }
      },
      computed: {
        messageText: function () {
          return n.default.link(i.default.escape(this.data.text), {
            className: "chatLink",
            truncate: {
              length: 50,
              location: "smart"
            }
          })
        }
      }
    }
  },
  "3moy": function (e, t) {},
  "6lTj": function (e, t, s) {
    "use strict";
    var i = {
      render: function () {
        var e = this,
          t = e.$createElement,
          s = e._self._c || t;
        return s("div", {
          staticClass: "user-list"
        }, [s("table", {
          staticStyle: {
            "padding-top": "5px"
          }
        }, [s("tbody", e._l(e.participants, function (t) {
          return s("tr", {
            key: t.id
          }, [s("td", {
            staticStyle: {
              "text-align": "center"
            }
          }, [s("img", {
            staticClass: "img-msg",
            attrs: {
              src: t.imageUrl
            }
          })]), e._v(" "), s("td", [e._v(e._s(t.name))])])
        }))])])
      },
      staticRenderFns: []
    };
    t.a = i
  },
  "7cnT": function (e, t, s) {
    "use strict";
    Object.defineProperty(t, "__esModule", {
      value: !0
    });
    var i = s("8AdB"),
      n = s.n(i);
    for (var a in i) "default" !== a && function (e) {
      s.d(t, e, function () {
        return i[e]
      })
    }(a);
    var r = s("8vo/");
    var o = function (e) {
        s("lxa1")
      },
      c = s("VU/8")(n.a, r.a, !1, o, "data-v-0d7c4722", null);
    t.default = c.exports
  },
  "80Sr": function (e, t, s) {
    "use strict";
    Object.defineProperty(t, "__esModule", {
      value: !0
    });
    var i, n = s("ThK4"),
      a = (i = n) && i.__esModule ? i : {
        default: i
      };
    t.default = {
      components: {
        EmojiPicker: a.default
      },
      data: function () {
        return {
          isActive: !1
        }
      },
      props: {
        onEmojiPicked: {
          type: Function,
          required: !0
        },
        color: {
          type: String,
          required: !0
        }
      },
      methods: {
        _openPicker: function (e) {
          this.isActive = !this.isActive
        },
        _handlePickerBlur: function () {
          this.isActive = !1
        }
      }
    }
  },
  "8AdB": function (e, t, s) {
    "use strict";
    Object.defineProperty(t, "__esModule", {
      value: !0
    }), t.default = {
      props: {
        onClick: {
          type: Function,
          required: !0
        },
        color: {
          type: String,
          required: !0
        }
      }
    }
  },
  "8vo/": function (e, t, s) {
    "use strict";
    var i = {
      render: function () {
        var e = this,
          t = e.$createElement,
          s = e._self._c || t;
        return s("button", {
          staticClass: "sc-user-input--send-icon-wrapper",
          on: {
            click: function (t) {
              return t.preventDefault(), e.onClick(t)
            }
          }
        }, [s("svg", {
          staticClass: "sc-user-input--send-icon",
          attrs: {
            version: "1.1",
            xmlns: "http://www.w3.org/2000/svg",
            x: "0px",
            y: "0px",
            width: "37.393px",
            height: "37.393px",
            viewBox: "0 0 37.393 37.393",
            enableBackground: "new 0 0 37.393 37.393"
          }
        }, [s("g", {
          attrs: {
            id: "Layer_2"
          }
        }, [s("path", {
          style: {
            fill: e.color
          },
          attrs: {
            d: "M36.511,17.594L2.371,2.932c-0.374-0.161-0.81-0.079-1.1,0.21C0.982,3.43,0.896,3.865,1.055,4.241l5.613,13.263\n        L2.082,32.295c-0.115,0.372-0.004,0.777,0.285,1.038c0.188,0.169,0.427,0.258,0.67,0.258c0.132,0,0.266-0.026,0.392-0.08\n        l33.079-14.078c0.368-0.157,0.607-0.519,0.608-0.919S36.879,17.752,36.511,17.594z M4.632,30.825L8.469,18.45h8.061\n        c0.552,0,1-0.448,1-1s-0.448-1-1-1H8.395L3.866,5.751l29.706,12.757L4.632,30.825z"
          }
        })])])])
      },
      staticRenderFns: []
    };
    t.a = i
  },
  "9QaW": function (e, t) {
    e.exports = "data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHhtbG5zOnhsaW5rPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hsaW5rIiB2aWV3Qm94PSItNDc0OS40OCAtNTAyMCAzNS4wMzYgMzUuMDM2Ij48ZGVmcz48c3R5bGU+LmF7ZmlsbDpub25lO30uYntmaWxsOiM0ZThjZmY7fS5je2NsaXAtcGF0aDp1cmwoI2EpO30uZHtmaWxsOiNmZmY7fS5le2ZpbGw6I2VmZjRmOTt9PC9zdHlsZT48Y2xpcFBhdGggaWQ9ImEiPjxwYXRoIGNsYXNzPSJhIiBkPSJNMC0zOTkuNDc5SDE3LjU1NXYxNy41NTVIMFoiIHRyYW5zZm9ybT0idHJhbnNsYXRlKDAgMzk5LjQ3OSkiLz48L2NsaXBQYXRoPjwvZGVmcz48ZyB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtNDg4NiAtNTA3NSkiPjxnIHRyYW5zZm9ybT0idHJhbnNsYXRlKDE0NS4xMyA2NCkiPjxnIGNsYXNzPSJjIj48ZyB0cmFuc2Zvcm09InRyYW5zbGF0ZSgwIDApIj48cGF0aCBjbGFzcz0iZCIgZD0iTS0zODEuOTI0LTE5MC45NjJhOC43NzgsOC43NzgsMCwwLDAtOC43NzgtOC43NzgsOC43NzgsOC43NzgsMCwwLDAtOC43NzgsOC43NzgsOC43NDUsOC43NDUsMCwwLDAsMi4yNiw1Ljg3OXYxLjQ0MmMwLC44LjQ5MiwxLjQ1NywxLjEsMS40NTdoNS44M2EuODQzLjg0MywwLDAsMCwuMTgzLS4wMiw4Ljc3OCw4Ljc3OCwwLDAsMCw4LjE4NC04Ljc1NyIgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoMzk5LjQ3OSAxOTkuNzQpIi8+PC9nPjxnIHRyYW5zZm9ybT0idHJhbnNsYXRlKDAgMCkiPjxwYXRoIGNsYXNzPSJlIiBkPSJNLTY4Ljc2My0xOTQuMDc5YTkuMjkyLDkuMjkyLDAsMCwxLDYuMzgtOC44ODhjLS4yNTItLjAyMi0uNTA2LS4wMzMtLjc2My0uMDMzYTguNzc0LDguNzc0LDAsMCwwLTguNzc4LDguNzc4QTkuNTA4LDkuNTA4LDAsMCwwLTY5LjctMTg4LjNjLjAwNSwwLDAsLjAwOSwwLC4wMS0uMzExLjM1Mi0xLjkyNCwyLjg0OS4wMjEsMi44NDloMi4yNWMtMS4yMy0uMDIyLDEuMjYzLTIuMTA3LjI2OS0zLjQ5NGE4LjIyNSw4LjIyNSwwLDAsMS0xLjYtNS4xNDEiIHRyYW5zZm9ybT0idHJhbnNsYXRlKDcxLjkyNCAyMDMpIi8+PC9nPjwvZz48L2c+PC9nPjwvc3ZnPg=="
  },
  ABnn: function (e, t, s) {
    "use strict";
    var i = {
      render: function () {
        var e = this,
          t = e.$createElement,
          s = e._self._c || t;
        return s("div", {
          ref: "domNode",
          staticClass: "sc-emoji-picker",
          attrs: {
            tabIndex: "0"
          },
          on: {
            blur: e.onBlur
          }
        }, [s("div", {
          staticClass: "sc-emoji-picker--content"
        }, e._l(e.emojiData, function (t) {
          return s("div", {
            key: t.name,
            staticClass: "sc-emoji-picker--category"
          }, [s("div", {
            staticClass: "sc-emoji-picker--category-title"
          }, [e._v(e._s(t.name))]), e._v(" "), e._l(t.emojis, function (t) {
            return s("span", {
              key: t,
              staticClass: "sc-emoji-picker--emoji",
              on: {
                click: function (s) {
                  e.emojiClicked(t)
                }
              }
            }, [e._v("\n          " + e._s(t) + "\n        ")])
          })], 2)
        }))])
      },
      staticRenderFns: []
    };
    t.a = i
  },
  AMWu: function (e, t) {},
  CAjv: function (e, t, s) {
    "use strict";
    Object.defineProperty(t, "__esModule", {
      value: !0
    });
    var i = o(s("lwql")),
      n = o(s("wyO6")),
      a = o(s("WQZp")),
      r = o(s("uezS"));

    function o(e) {
      return e && e.__esModule ? e : {
        default: e
      }
    }
    t.default = {
      components: {
        Header: i.default,
        MessageList: n.default,
        UserInput: a.default,
        UserList: r.default
      },
      props: {
        showEmoji: {
          type: Boolean,
          default: !1
        },
        showFile: {
          type: Boolean,
          default: !1
        },
        participants: {
          type: Array,
          required: !0
        },
        title: {
          type: String,
          required: !0
        },
        titleImageUrl: {
          type: String,
          default: ""
        },
        onUserInputSubmit: {
          type: Function,
          required: !0
        },
        onClose: {
          type: Function,
          required: !0
        },
        messageList: {
          type: Array,
          default: function () {
            return []
          }
        },
        isOpen: {
          type: Boolean,
          default: function () {
            return !1
          }
        },
        placeholder: {
          type: String,
          default: "Write a reply"
        },
        showTypingIndicator: {
          type: String,
          required: !0
        },
        colors: {
          type: Object,
          required: !0
        },
        alwaysScrollToBottom: {
          type: Boolean,
          required: !0
        }
      },
      data: function () {
        return {
          showUserList: !1
        }
      },
      computed: {
        messages: function () {
          var e = this.messageList;
          return e
        }
      },
      methods: {
        handleUserListToggle: function (e) {
          this.showUserList = e
        }
      }
    }
  },
  CnRt: function (e, t) {},
  DSz4: function (e, t, s) {
    "use strict";
    Object.defineProperty(t, "__esModule", {
      value: !0
    }), t.default = {
      props: {
        data: {
          type: Object,
          required: !0
        },
        messageColors: {
          type: Object,
          required: !0
        }
      }
    }
  },
  F4br: function (e, t) {},
  IOiW: function (e, t, s) {
    "use strict";
    Object.defineProperty(t, "__esModule", {
      value: !0
    }), t.default = {
      props: {
        messageColors: {
          type: Object,
          required: !0
        }
      }
    }
  },
  JWZU: function (e, t, s) {
    "use strict";
    var i = {
      render: function () {
        var e = this,
          t = e.$createElement,
          i = e._self._c || t;
        return i("div", {
          staticClass: "sc-header",
          style: {
            background: e.colors.header.bg,
            color: e.colors.header.text
          }
        }, [e.imageUrl ? i("img", {
          staticClass: "sc-header--img",
          attrs: {
            src: e.imageUrl,
            alt: ""
          }
        }) : e._e(), e._v(" "), i("div", {
          staticClass: "sc-header--title",
          on: {
            click: e.toggleUserList
          }
        }, [e._v(" " + e._s(e.title) + " ")]), e._v(" "), i("div", {
          staticClass: "sc-header--close-button",
          on: {
            click: e.onClose
          }
        }, [i("img", {
          attrs: {
            src: s("xc3+"),
            alt: ""
          }
        })])])
      },
      staticRenderFns: []
    };
    t.a = i
  },
  Jf5X: function (e, t, s) {
    "use strict";
    Object.defineProperty(t, "__esModule", {
      value: !0
    });
    var i = s("CAjv"),
      n = s.n(i);
    for (var a in i) "default" !== a && function (e) {
      s.d(t, e, function () {
        return i[e]
      })
    }(a);
    var r = s("XfmN");
    var o = function (e) {
        s("QDdA")
      },
      c = s("VU/8")(n.a, r.a, !1, o, "data-v-3e1250f3", null);
    t.default = c.exports
  },
  "K/BQ": function (e, t, s) {
    "use strict";
    Object.defineProperty(t, "__esModule", {
      value: !0
    });
    var i = s("3ab+"),
      n = s.n(i);
    for (var a in i) "default" !== a && function (e) {
      s.d(t, e, function () {
        return i[e]
      })
    }(a);
    var r = s("0C6+");
    var o = function (e) {
        s("AMWu")
      },
      c = s("VU/8")(n.a, r.a, !1, o, "data-v-0599ea28", null);
    t.default = c.exports
  },
  "K1/R": function (e, t, s) {
    "use strict";
    Object.defineProperty(t, "__esModule", {
      value: !0
    });
    var i = u(s("K/BQ")),
      n = u(s("pAjY")),
      a = u(s("xemH")),
      r = u(s("oSDv")),
      o = u(s("LYnd")),
      c = u(s("d1QR"));

    function u(e) {
      return e && e.__esModule ? e : {
        default: e
      }
    }
    t.default = {
      data: function () {
        return {}
      },
      components: {
        TextMessage: i.default,
        FileMessage: n.default,
        EmojiMessage: a.default,
        TypingMessage: r.default,
        SystemMessage: o.default
      },
      props: {
        message: {
          type: Object,
          required: !0
        },
        chatImageUrl: {
          type: String,
          default: c.default
        },
        colors: {
          type: Object,
          required: !0
        },
        authorName: {
          type: String
        }
      },
      methods: {
        sentColorsStyle: function () {
          return {
            color: this.colors.sentMessage.text,
            backgroundColor: this.colors.sentMessage.bg
          }
        },
        receivedColorsStyle: function () {
          return {
            color: this.colors.receivedMessage.text,
            backgroundColor: this.colors.receivedMessage.bg
          }
        },
        determineMessageColors: function () {
          return "me" === this.message.author ? this.sentColorsStyle() : this.receivedColorsStyle()
        }
      }
    }
  },
  KBUR: function (e, t) {},
  KPpO: function (e, t) {},
  LAyR: function (e, t, s) {
    "use strict";
    var i = {
      render: function () {
        var e = this.$createElement,
          t = this._self._c || e;
        return t("div", {
          staticClass: "sc-typing-indicator",
          style: this.messageColors
        }, [t("span"), this._v(" "), t("span"), this._v(" "), t("span")])
      },
      staticRenderFns: []
    };
    t.a = i
  },
  LYnd: function (e, t, s) {
    "use strict";
    Object.defineProperty(t, "__esModule", {
      value: !0
    });
    var i = s("DSz4"),
      n = s.n(i);
    for (var a in i) "default" !== a && function (e) {
      s.d(t, e, function () {
        return i[e]
      })
    }(a);
    var r = s("h8yb");
    var o = function (e) {
        s("F4br")
      },
      c = s("VU/8")(n.a, r.a, !1, o, "data-v-134389cf", null);
    t.default = c.exports
  },
  NDEY: function (e, t) {},
  NHnr: function (e, t, s) {
    "use strict";
    Object.defineProperty(t, "__esModule", {
      value: !0
    });
    var i = s("7+uW"),
      n = s("zUV7"),
      a = s("Gu7T"),
      r = s.n(a),
      o = s("mtWM"),
      c = s.n(o),
      u = {
        name: "app",
        data: function () {
          return {
            nextAPI: "",
            sendingMsg: !1,
            participants: [{
              id: "alergia_sam",
              name: "AlergiaSam",
              imageUrl: "./static/img/logo.png"
            }],
            titleImageUrl: "./static/img/logo2.png",
            messageList: [],
            newMessagesCount: 0,
            isChatOpen: !0,
            showTypingIndicator: "",
            colors: {
              header: {
                bg: "#4e8cff",
                text: "#ffffff"
              },
              launcher: {
                bg: "#4e8cff"
              },
              messageList: {
                bg: "#ffffff"
              },
              sentMessage: {
                bg: "#4e8cff",
                text: "#ffffff"
              },
              receivedMessage: {
                bg: "#eaeaea",
                text: "#222222"
              },
              userInput: {
                bg: "#f4f7f9",
                text: "#565867"
              }
            },
            alwaysScrollToBottom: !1
          }
        },
        methods: {
          axios: function (e) {
            return c.a.get("http://localhost:8008/send/" + this.nextAPI + e).then(function (e) {
              return console.log(e.data), e.data
            }).catch(function (e) {
              console.error(e)
            })
          },
          sendMessage: function (e) {
            e.length > 0 && (this.newMessagesCount = this.isChatOpen ? this.newMessagesCount : this.newMessagesCount + 1, this.messageList = [].concat(r()(this.messageList), [{
              author: "alergia_sam",
              type: "text",
              data: {
                text: e
              }
            }]))
          },
          onMessageWasSent: function (e) {
            var t = this;
            this.sendingMsg || (this.sendingMsg = !0, this.messageList = [].concat(r()(this.messageList), [e]), this.axios("/" + e.data.text).then(function (e) {
              var s = e.message,
                i = e.next,
                n = e.meta;
              t.nextAPI = i || t.nextAPI, void 0 !== n ? (s.forEach(function (e, s) {
                if (void 0 !== n.replace) {
                  var i = e.match(/~w/g);
                  if (i) {
                    i = i.length;
                    for (var a = 0; a < i; a += 1) e = e.replace("~w", n.replace[a].toUpperCase())
                  }
                }
                setTimeout(function () {
                  t.sendMessage(e)
                }, 160 * (s + 1))
              }), void 0 !== n.idSintoma && (t.nextAPI = i + "/" + n.idSintoma)) : s.forEach(function (e, s) {
                setTimeout(function () {
                  t.sendMessage(e)
                }, 200 * (s + 1))
              })
            }).catch(function (e) {
              console.error(e)
            }).finally(function () {
              t.sendingMsg = !1
            }))
          },
          openChat: function () {
            this.isChatOpen = !0, this.newMessagesCount = 0
          },
          closeChat: function () {
            this.isChatOpen = !1
          }
        },
        created: function () {
          var e = this;
          this.axios("start").then(function (t) {
            var s = t.message,
              i = t.next;
            e.nextAPI = i || e.nextAPI, s.forEach(function (t, s) {
              setTimeout(function () {
                e.sendMessage(t)
              }, 200 * (s + 1))
            })
          }).catch(function (e) {
            console.error(e)
          })
        }
      },
      l = {
        render: function () {
          var e = this,
            t = e.$createElement,
            s = e._self._c || t;
          return s("div", [s("beautiful-chat", {
            attrs: {
              participants: e.participants,
              titleImageUrl: e.titleImageUrl,
              onMessageWasSent: e.onMessageWasSent,
              messageList: e.messageList,
              newMessagesCount: e.newMessagesCount,
              isOpen: e.isChatOpen,
              close: e.closeChat,
              open: e.openChat,
              showEmoji: !1,
              showFile: !1,
              showTypingIndicator: e.showTypingIndicator,
              colors: e.colors,
              alwaysScrollToBottom: e.alwaysScrollToBottom
            }
          })], 1)
        },
        staticRenderFns: []
      };
    var d = {
        name: "App",
        components: {
          HelloWorld: s("VU/8")(u, l, !1, function (e) {
            s("uBBs")
          }, null, null).exports
        }
      },
      M = {
        render: function () {
          var e = this.$createElement,
            t = this._self._c || e;
          return t("div", {
            attrs: {
              id: "app"
            }
          }, [t("HelloWorld")], 1)
        },
        staticRenderFns: []
      };
    var g = s("VU/8")(d, M, !1, function (e) {
      s("NDEY")
    }, null, null).exports;
    i.a.use(n.a), i.a.config.productionTip = !1, new i.a({
      el: "#app",
      components: {
        App: g
      },
      template: "<App/>"
    })
  },
  Nkf6: function (e, t) {},
  "P1/Q": function (e, t) {},
  PFUe: function (e, t, s) {
    "use strict";
    Object.defineProperty(t, "__esModule", {
      value: !0
    });
    var i = s("K1/R"),
      n = s.n(i);
    for (var a in i) "default" !== a && function (e) {
      s.d(t, e, function () {
        return i[e]
      })
    }(a);
    var r = s("YzVk");
    var o = function (e) {
        s("erj1")
      },
      c = s("VU/8")(n.a, r.a, !1, o, null, null);
    t.default = c.exports
  },
  QDdA: function (e, t) {},
  Sihk: function (e, t, s) {
    "use strict";
    Object.defineProperty(t, "__esModule", {
      value: !0
    }), t.default = {
      props: {
        onChange: {
          type: Function,
          required: !0
        },
        color: {
          type: String,
          required: !0
        }
      },
      methods: {
        _handleClick: function (e) {
          e.target.value = null
        },
        _handleChange: function (e) {
          this.onChange(e.target.files[0])
        }
      }
    }
  },
  SmVv: function (e, t, s) {
    "use strict";
    Object.defineProperty(t, "__esModule", {
      value: !0
    }), t.default = {
      props: {
        data: {
          type: Object,
          required: !0
        },
        messageColors: {
          type: Object,
          required: !0
        }
      }
    }
  },
  ThK4: function (e, t, s) {
    "use strict";
    Object.defineProperty(t, "__esModule", {
      value: !0
    });
    var i = s("mrGr"),
      n = s.n(i);
    for (var a in i) "default" !== a && function (e) {
      s.d(t, e, function () {
        return i[e]
      })
    }(a);
    var r = s("ABnn");
    var o = function (e) {
        s("CnRt")
      },
      c = s("VU/8")(n.a, r.a, !1, o, "data-v-186501e1", null);
    t.default = c.exports
  },
  WQZp: function (e, t, s) {
    "use strict";
    Object.defineProperty(t, "__esModule", {
      value: !0
    });
    var i = s("sL4Z"),
      n = s.n(i);
    for (var a in i) "default" !== a && function (e) {
      s.d(t, e, function () {
        return i[e]
      })
    }(a);
    var r = s("cDjH");
    var o = function (e) {
        s("3moy")
      },
      c = s("VU/8")(n.a, r.a, !1, o, null, null);
    t.default = c.exports
  },
  XfmN: function (e, t, s) {
    "use strict";
    var i = {
      render: function () {
        var e = this,
          t = e.$createElement,
          s = e._self._c || t;
        return s("div", {
          staticClass: "sc-chat-window",
          class: {
            opened: e.isOpen, closed: !e.isOpen
          }
        }, [s("Header", {
          attrs: {
            title: e.title,
            imageUrl: e.titleImageUrl,
            onClose: e.onClose,
            colors: e.colors
          },
          on: {
            userList: e.handleUserListToggle
          }
        }), e._v(" "), e.showUserList ? s("UserList", {
          attrs: {
            participants: e.participants
          }
        }) : e._e(), e._v(" "), e.showUserList ? e._e() : s("MessageList", {
          attrs: {
            messages: e.messages,
            participants: e.participants,
            showTypingIndicator: e.showTypingIndicator,
            colors: e.colors,
            alwaysScrollToBottom: e.alwaysScrollToBottom
          }
        }), e._v(" "), e.showUserList ? e._e() : s("UserInput", {
          attrs: {
            showEmoji: e.showEmoji,
            onSubmit: e.onUserInputSubmit,
            showFile: e.showFile,
            placeholder: e.placeholder,
            colors: e.colors
          }
        })], 1)
      },
      staticRenderFns: []
    };
    t.a = i
  },
  YzVk: function (e, t, s) {
    "use strict";
    var i = {
      render: function () {
        var e = this,
          t = e.$createElement,
          s = e._self._c || t;
        return s("div", {
          staticClass: "sc-message"
        }, [s("div", {
          staticClass: "sc-message--content",
          class: {
            sent: "me" === e.message.author, received: "me" !== e.message.author && "system" !== e.message.type, system: "system" === e.message.type
          }
        }, ["system" !== e.message.type ? s("div", {
          directives: [{
            name: "tooltip",
            rawName: "v-tooltip",
            value: e.message.author,
            expression: "message.author"
          }],
          staticClass: "sc-message--avatar",
          style: {
            backgroundImage: "url(" + e.chatImageUrl + ")"
          },
          attrs: {
            title: e.authorName
          }
        }) : e._e(), e._v(" "), "text" === e.message.type ? s("TextMessage", {
          attrs: {
            data: e.message.data,
            messageColors: e.determineMessageColors()
          }
        }) : "emoji" === e.message.type ? s("EmojiMessage", {
          attrs: {
            data: e.message.data
          }
        }) : "file" === e.message.type ? s("FileMessage", {
          attrs: {
            data: e.message.data,
            messageColors: e.determineMessageColors()
          }
        }) : "typing" === e.message.type ? s("TypingMessage", {
          attrs: {
            messageColors: e.determineMessageColors()
          }
        }) : "system" === e.message.type ? s("SystemMessage", {
          attrs: {
            data: e.message.data,
            messageColors: e.determineMessageColors()
          }
        }) : e._e()], 1)])
      },
      staticRenderFns: []
    };
    t.a = i
  },
  "aCP/": function (e, t, s) {
    "use strict";
    Object.defineProperty(t, "__esModule", {
      value: !0
    });
    var i = s("Sihk"),
      n = s.n(i);
    for (var a in i) "default" !== a && function (e) {
      s.d(t, e, function () {
        return i[e]
      })
    }(a);
    var r = s("mAAH");
    var o = function (e) {
        s("KBUR")
      },
      c = s("VU/8")(n.a, r.a, !1, o, "data-v-9affe3a0", null);
    t.default = c.exports
  },
  aLFs: function (e, t) {
    e.exports = "data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iaXNvLTg4NTktMSI/Pgo8IS0tIEdlbmVyYXRvcjogQWRvYmUgSWxsdXN0cmF0b3IgMTkuMC4wLCBTVkcgRXhwb3J0IFBsdWctSW4gLiBTVkcgVmVyc2lvbjogNi4wMCBCdWlsZCAwKSAgLS0+CjxzdmcgdmVyc2lvbj0iMS4xIiBpZD0iQ2FwYV8xIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHhtbG5zOnhsaW5rPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hsaW5rIiB4PSIwcHgiIHk9IjBweCIKCSB2aWV3Qm94PSIwIDAgNDcuOTcxIDQ3Ljk3MSIgc3R5bGU9ImVuYWJsZS1iYWNrZ3JvdW5kOm5ldyAwIDAgNDcuOTcxIDQ3Ljk3MTsiIHhtbDpzcGFjZT0icHJlc2VydmUiPgo8Zz4KCTxwYXRoIGQ9Ik0yOC4yMjgsMjMuOTg2TDQ3LjA5Miw1LjEyMmMxLjE3Mi0xLjE3MSwxLjE3Mi0zLjA3MSwwLTQuMjQyYy0xLjE3Mi0xLjE3Mi0zLjA3LTEuMTcyLTQuMjQyLDBMMjMuOTg2LDE5Ljc0NEw1LjEyMSwwLjg4CgkJYy0xLjE3Mi0xLjE3Mi0zLjA3LTEuMTcyLTQuMjQyLDBjLTEuMTcyLDEuMTcxLTEuMTcyLDMuMDcxLDAsNC4yNDJsMTguODY1LDE4Ljg2NEwwLjg3OSw0Mi44NWMtMS4xNzIsMS4xNzEtMS4xNzIsMy4wNzEsMCw0LjI0MgoJCUMxLjQ2NSw0Ny42NzcsMi4yMzMsNDcuOTcsMyw0Ny45N3MxLjUzNS0wLjI5MywyLjEyMS0wLjg3OWwxOC44NjUtMTguODY0TDQyLjg1LDQ3LjA5MWMwLjU4NiwwLjU4NiwxLjM1NCwwLjg3OSwyLjEyMSwwLjg3OQoJCXMxLjUzNS0wLjI5MywyLjEyMS0wLjg3OWMxLjE3Mi0xLjE3MSwxLjE3Mi0zLjA3MSwwLTQuMjQyTDI4LjIyOCwyMy45ODZ6Ii8+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPC9zdmc+"
  },
  bs93: function (e, t) {},
  cDjH: function (e, t, s) {
    "use strict";
    var i = {
      render: function () {
        var e = this,
          t = e.$createElement,
          i = e._self._c || t;
        return i("div", [e.file ? i("div", {
          staticClass: "file-container",
          style: {
            backgroundColor: e.colors.userInput.text,
            color: e.colors.userInput.bg
          }
        }, [e._m(0), e._v("\n    " + e._s(e.file.name) + "\n    "), i("span", {
          staticClass: "delete-file-message",
          on: {
            click: function (t) {
              e.cancelFile()
            }
          }
        }, [i("img", {
          attrs: {
            src: s("aLFs"),
            alt: "close icon",
            height: "10",
            title: "Remove the file"
          }
        })])]) : e._e(), e._v(" "), i("form", {
          staticClass: "sc-user-input",
          class: {
            active: e.inputActive
          },
          style: {
            background: e.colors.userInput.bg
          }
        }, [i("div", {
          ref: "userInput",
          staticClass: "sc-user-input--text",
          style: {
            color: e.colors.userInput.text
          },
          attrs: {
            role: "button",
            tabIndex: "0",
            contentEditable: "true",
            placeholder: e.placeholder
          },
          on: {
            focus: function (t) {
              e.setInputActive(!0)
            },
            blur: function (t) {
              e.setInputActive(!1)
            },
            keydown: e.handleKey
          }
        }), e._v(" "), i("div", {
          staticClass: "sc-user-input--buttons"
        }, [i("div", {
          staticClass: "sc-user-input--button"
        }), e._v(" "), e.showEmoji ? i("div", {
          staticClass: "sc-user-input--button"
        }, [i("EmojiIcon", {
          attrs: {
            onEmojiPicked: e._handleEmojiPicked,
            color: e.colors.userInput.text
          }
        })], 1) : e._e(), e._v(" "), e.showFile ? i("div", {
          staticClass: "sc-user-input--button"
        }, [i("FileIcons", {
          attrs: {
            onChange: e._handleFileSubmit,
            color: e.colors.userInput.text
          }
        })], 1) : e._e(), e._v(" "), i("div", {
          staticClass: "sc-user-input--button"
        }, [i("SendIcon", {
          attrs: {
            onClick: e._submitText,
            color: e.colors.userInput.text
          }
        })], 1)])])])
      },
      staticRenderFns: [function () {
        var e = this.$createElement,
          t = this._self._c || e;
        return t("span", {
          staticClass: "icon-file-message"
        }, [t("img", {
          attrs: {
            src: s("w+sz"),
            alt: "genericFileIcon",
            height: "15"
          }
        })])
      }]
    };
    t.a = i
  },
  d1QR: function (e, t) {
    e.exports = "data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHhtbG5zOnhsaW5rPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hsaW5rIiB2aWV3Qm94PSItNDc0OS40OCAtNTAyMCAzNS4wMzYgMzUuMDM2Ij48ZGVmcz48c3R5bGU+LmF7ZmlsbDpub25lO30uYntmaWxsOiM0ZThjZmY7fS5je2NsaXAtcGF0aDp1cmwoI2EpO30uZHtmaWxsOiNmZmY7fS5le2ZpbGw6I2VmZjRmOTt9PC9zdHlsZT48Y2xpcFBhdGggaWQ9ImEiPjxwYXRoIGNsYXNzPSJhIiBkPSJNMC0zOTkuNDc5SDE3LjU1NXYxNy41NTVIMFoiIHRyYW5zZm9ybT0idHJhbnNsYXRlKDAgMzk5LjQ3OSkiLz48L2NsaXBQYXRoPjwvZGVmcz48ZyB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtNDg4NiAtNTA3NSkiPjxjaXJjbGUgY2xhc3M9ImIiIGN4PSIxNy41MTgiIGN5PSIxNy41MTgiIHI9IjE3LjUxOCIgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoMTM2LjUyIDU1KSIvPjxnIHRyYW5zZm9ybT0idHJhbnNsYXRlKDE0NS4xMyA2NCkiPjxnIGNsYXNzPSJjIj48ZyB0cmFuc2Zvcm09InRyYW5zbGF0ZSgwIDApIj48cGF0aCBjbGFzcz0iZCIgZD0iTS0zODEuOTI0LTE5MC45NjJhOC43NzgsOC43NzgsMCwwLDAtOC43NzgtOC43NzgsOC43NzgsOC43NzgsMCwwLDAtOC43NzgsOC43NzgsOC43NDUsOC43NDUsMCwwLDAsMi4yNiw1Ljg3OXYxLjQ0MmMwLC44LjQ5MiwxLjQ1NywxLjEsMS40NTdoNS44M2EuODQzLjg0MywwLDAsMCwuMTgzLS4wMiw4Ljc3OCw4Ljc3OCwwLDAsMCw4LjE4NC04Ljc1NyIgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoMzk5LjQ3OSAxOTkuNzQpIi8+PC9nPjxnIHRyYW5zZm9ybT0idHJhbnNsYXRlKDAgMCkiPjxwYXRoIGNsYXNzPSJlIiBkPSJNLTY4Ljc2My0xOTQuMDc5YTkuMjkyLDkuMjkyLDAsMCwxLDYuMzgtOC44ODhjLS4yNTItLjAyMi0uNTA2LS4wMzMtLjc2My0uMDMzYTguNzc0LDguNzc0LDAsMCwwLTguNzc4LDguNzc4QTkuNTA4LDkuNTA4LDAsMCwwLTY5LjctMTg4LjNjLjAwNSwwLDAsLjAwOSwwLC4wMS0uMzExLjM1Mi0xLjkyNCwyLjg0OS4wMjEsMi44NDloMi4yNWMtMS4yMy0uMDIyLDEuMjYzLTIuMTA3LjI2OS0zLjQ5NGE4LjIyNSw4LjIyNSwwLDAsMS0xLjYtNS4xNDEiIHRyYW5zZm9ybT0idHJhbnNsYXRlKDcxLjkyNCAyMDMpIi8+PC9nPjwvZz48L2c+PC9nPjwvc3ZnPg=="
  },
  erj1: function (e, t) {},
  h8yb: function (e, t, s) {
    "use strict";
    var i = {
      render: function () {
        var e = this,
          t = e.$createElement,
          s = e._self._c || t;
        return s("div", {
          staticClass: "sc-message--system",
          style: e.messageColors
        }, [e._v(e._s(e.data.text)), e.data.meta ? s("p", {
          staticClass: "sc-message--meta",
          style: {
            color: e.messageColors.color
          }
        }, [e._v(e._s(e.data.meta))]) : e._e()])
      },
      staticRenderFns: []
    };
    t.a = i
  },
  hKb2: function (e, t, s) {
    "use strict";
    Object.defineProperty(t, "__esModule", {
      value: !0
    }), t.default = {
      props: {
        imageUrl: {
          type: String,
          required: !0
        },
        title: {
          type: String
        },
        onClose: {
          type: Function,
          required: !0
        },
        colors: {
          type: Object,
          required: !0
        }
      },
      methods: {
        toggleUserList: function () {
          this.inUserList = !this.inUserList, this.$emit("userList", this.inUserList)
        }
      },
      data: function () {
        return {
          inUserList: !1
        }
      }
    }
  },
  jG83: function (e, t, s) {
    "use strict";
    var i = {
      render: function () {
        var e = this,
          t = e.$createElement,
          s = e._self._c || t;
        return s("div", {
          staticClass: "sc-user-input--picker-wrapper"
        }, [e.isActive ? s("EmojiPicker", {
          attrs: {
            onEmojiPicked: e.onEmojiPicked,
            onBlur: e._handlePickerBlur
          }
        }) : e._e(), e._v(" "), s("button", {
          staticClass: "sc-user-input--emoji-icon-wrapper",
          on: {
            click: function (t) {
              return t.preventDefault(), e._openPicker(t)
            }
          }
        }, [s("svg", {
          staticClass: "sc-user-input--emoji-icon",
          class: {
            active: e.isActive
          },
          attrs: {
            version: "1.1",
            id: "Layer_2",
            xmlns: "http://www.w3.org/2000/svg",
            x: "0px",
            y: "0px",
            width: "37.393px",
            height: "37.393px",
            viewBox: "0 0 37.393 37.393",
            enableBackground: "new 0 0 37.393 37.393"
          }
        }, [s("g", [s("path", {
          style: {
            fill: e.color
          },
          attrs: {
            d: "M18.696,37.393C8.387,37.393,0,29.006,0,18.696C0,8.387,8.387,0,18.696,0c10.31,0,18.696,8.387,18.696,18.696\n            C37.393,29.006,29.006,37.393,18.696,37.393z M18.696,2C9.49,2,2,9.49,2,18.696c0,9.206,7.49,16.696,16.696,16.696\n            c9.206,0,16.696-7.49,16.696-16.696C35.393,9.49,27.902,2,18.696,2z"
          }
        })]), e._v(" "), s("g", [s("circle", {
          style: {
            fill: e.color
          },
          attrs: {
            cx: "12.379",
            cy: "14.359",
            r: "1.938"
          }
        })]), e._v(" "), s("g", [s("circle", {
          style: {
            fill: e.color
          },
          attrs: {
            cx: "24.371",
            cy: "14.414",
            r: "1.992"
          }
        })]), e._v(" "), s("g", [s("path", {
          style: {
            fill: e.color
          },
          attrs: {
            d: "M18.035,27.453c-5.748,0-8.342-4.18-8.449-4.357c-0.286-0.473-0.135-1.087,0.338-1.373\n            c0.471-0.286,1.084-0.136,1.372,0.335c0.094,0.151,2.161,3.396,6.74,3.396c4.713,0,7.518-3.462,7.545-3.497\n            c0.343-0.432,0.973-0.504,1.405-0.161c0.433,0.344,0.505,0.973,0.161,1.405C27.009,23.374,23.703,27.453,18.035,27.453z"
          }
        })])])])], 1)
      },
      staticRenderFns: []
    };
    t.a = i
  },
  jSRS: function (e, t, s) {
    "use strict";
    Object.defineProperty(t, "__esModule", {
      value: !0
    });
    var i, n = s("Jf5X"),
      a = (i = n) && i.__esModule ? i : {
        default: i
      };
    t.default = {
      props: {
        showEmoji: {
          type: Boolean,
          default: !1
        },
        isOpen: {
          type: Boolean,
          required: !0
        },
        open: {
          type: Function,
          required: !0
        },
        close: {
          type: Function,
          required: !0
        },
        showFile: {
          type: Boolean,
          default: !1
        },
        participants: {
          type: Array,
          required: !0
        },
        title: {
          type: String,
          default: function () {
            return ""
          }
        },
        titleImageUrl: {
          type: String,
          default: function () {
            return ""
          }
        },
        onMessageWasSent: {
          type: Function,
          required: !0
        },
        messageList: {
          type: Array,
          default: function () {
            return []
          }
        },
        newMessagesCount: {
          type: Number,
          default: function () {
            return 0
          }
        },
        placeholder: {
          type: String,
          default: "Escribe un mensaje."
        },
        showTypingIndicator: {
          type: String,
          default: function () {
            return ""
          }
        },
        colors: {
          type: Object,
          required: !1,
          validator: function (e) {
            return "header" in e && "bg" in e.header && "text" in e.header && "launcher" in e && "bg" in e.launcher && "messageList" in e && "bg" in e.messageList && "sentMessage" in e && "bg" in e.sentMessage && "text" in e.sentMessage && "receivedMessage" in e && "bg" in e.receivedMessage && "text" in e.receivedMessage && "userInput" in e && "bg" in e.userInput && "text" in e.userInput
          },
          default: function () {
            return {
              header: {
                bg: "#4e8cff",
                text: "#ffffff"
              },
              launcher: {
                bg: "#4e8cff"
              },
              messageList: {
                bg: "#ffffff"
              },
              sentMessage: {
                bg: "#4e8cff",
                text: "#ffffff"
              },
              receivedMessage: {
                bg: "#f4f7f9",
                text: "#ffffff"
              },
              userInput: {
                bg: "#f4f7f9",
                text: "#565867"
              }
            }
          }
        },
        alwaysScrollToBottom: {
          type: Boolean,
          default: function () {
            return !1
          }
        }
      },
      computed: {
        chatWindowTitle: function () {
          return "" !== this.title ? this.title : this.participants.length > 1 ? "Vos, " + this.participants[0].name + " & otros" : "Vos & " + this.participants[0].name
        }
      },
      components: {
        ChatWindow: a.default
      }
    }
  },
  kEJf: function (e, t, s) {
    "use strict";
    Object.defineProperty(t, "__esModule", {
      value: !0
    });
    var i = s("80Sr"),
      n = s.n(i);
    for (var a in i) "default" !== a && function (e) {
      s.d(t, e, function () {
        return i[e]
      })
    }(a);
    var r = s("jG83");
    var o = function (e) {
        s("P1/Q")
      },
      c = s("VU/8")(n.a, r.a, !1, o, "data-v-0823abc8", null);
    t.default = c.exports
  },
  kl68: function (e, t, s) {
    "use strict";
    var i = {
      render: function () {
        var e = this,
          t = e.$createElement,
          i = e._self._c || t;
        return i("div", [i("div", {
          staticClass: "sc-launcher",
          class: {
            opened: e.isOpen
          },
          style: {
            backgroundColor: e.colors.launcher.bg
          },
          on: {
            click: function (t) {
              t.preventDefault(), e.isOpen ? e.close() : e.open()
            }
          }
        }, [e.newMessagesCount > 0 && !e.isOpen ? i("div", {
          staticClass: "sc-new-messsages-count"
        }, [e._v("\n      " + e._s(e.newMessagesCount) + "\n    ")]) : e._e(), e._v(" "), i("img", {
          staticClass: "sc-open-icon",
          attrs: {
            src: s("xc3+")
          }
        }), e._v(" "), i("img", {
          staticClass: "sc-closed-icon",
          attrs: {
            src: s("9QaW")
          }
        })]), e._v(" "), i("ChatWindow", {
          attrs: {
            messageList: e.messageList,
            onUserInputSubmit: e.onMessageWasSent,
            participants: e.participants,
            title: e.chatWindowTitle,
            titleImageUrl: e.titleImageUrl,
            isOpen: e.isOpen,
            onClose: e.close,
            showEmoji: e.showEmoji,
            showFile: e.showFile,
            placeholder: e.placeholder,
            showTypingIndicator: e.showTypingIndicator,
            colors: e.colors,
            alwaysScrollToBottom: e.alwaysScrollToBottom
          }
        })], 1)
      },
      staticRenderFns: []
    };
    t.a = i
  },
  lwox: function (e, t) {},
  lwql: function (e, t, s) {
    "use strict";
    Object.defineProperty(t, "__esModule", {
      value: !0
    });
    var i = s("hKb2"),
      n = s.n(i);
    for (var a in i) "default" !== a && function (e) {
      s.d(t, e, function () {
        return i[e]
      })
    }(a);
    var r = s("JWZU");
    var o = function (e) {
        s("KPpO")
      },
      c = s("VU/8")(n.a, r.a, !1, o, "data-v-43d21670", null);
    t.default = c.exports
  },
  lxa1: function (e, t) {},
  mAAH: function (e, t, s) {
    "use strict";
    var i = {
      render: function () {
        var e = this.$createElement,
          t = this._self._c || e;
        return t("label", {
          attrs: {
            htmlFor: "file-input"
          }
        }, [t("button", {
          staticClass: "sc-user-input--file-icon-wrapper",
          attrs: {
            type: "button"
          }
        }, [t("svg", {
          staticClass: "sc-user-input--file-icon",
          attrs: {
            version: "1.1",
            xmlns: "http://www.w3.org/2000/svg",
            x: "0px",
            y: "0px",
            width: "24px",
            height: "24px",
            viewBox: "0 0 37.393 37.393",
            enableBackground: "new 0 0 37.393 37.393"
          }
        }, [t("path", {
          style: {
            fill: this.color
          },
          attrs: {
            d: "M20.807 10.22l-2.030-2.029-10.15 10.148c-1.682 1.681-1.682 4.408 0 6.089s4.408 1.681 6.090 0l12.18-12.178c2.804-2.802 2.804-7.346 0-10.148-2.802-2.803-7.347-2.803-10.149 0l-12.788 12.787c-0.009 0.009-0.019 0.018-0.027 0.026-3.909 3.909-3.909 10.245 0 14.153 3.908 3.908 10.246 3.908 14.156 0 0.009-0.009 0.016-0.018 0.026-0.027l0.001 0.001 8.729-8.728-2.031-2.029-8.729 8.727c-0.009 0.008-0.018 0.018-0.026 0.026-2.784 2.783-7.312 2.783-10.096 0-2.783-2.783-2.783-7.31 0-10.093 0.010-0.009 0.019-0.018 0.028-0.026l-0.001-0.002 12.79-12.786c1.678-1.679 4.411-1.679 6.090 0s1.678 4.411 0 6.089l-12.18 12.178c-0.56 0.56-1.47 0.56-2.030 0-0.559-0.559-0.559-1.47 0-2.029l10.15-10.149z"
          }
        })])]), this._v(" "), t("input", {
          attrs: {
            type: "file",
            id: "file-input"
          },
          on: {
            change: this._handleChange,
            click: this._handleClick
          }
        })])
      },
      staticRenderFns: []
    };
    t.a = i
  },
  mrGr: function (e, t, s) {
    "use strict";
    Object.defineProperty(t, "__esModule", {
      value: !0
    });
    var i = a(s("m915")),
      n = a(s("VMA9"));

    function a(e) {
      return e && e.__esModule ? e : {
        default: e
      }
    }
    t.default = {
      data: function () {
        return {
          emojiData: n.default,
          emojiConvertor: new i.default
        }
      },
      props: {
        onBlur: {
          type: Function,
          required: !0
        },
        onEmojiPicked: {
          type: Function,
          required: !0
        }
      },
      methods: {
        emojiClicked: function (e) {
          this.onEmojiPicked(e), this.$refs.domNode.blur()
        }
      },
      mounted: function () {
        var e = this.$refs.domNode;
        e.style.opacity = 0, window.requestAnimationFrame(function () {
          e.style.transition = "opacity 350ms", e.style.opacity = 1
        }), this.$refs.domNode.focus(), this.emojiConvertor.init_env()
      }
    }
  },
  nZPl: function (e, t) {},
  oSDv: function (e, t, s) {
    "use strict";
    Object.defineProperty(t, "__esModule", {
      value: !0
    });
    var i = s("IOiW"),
      n = s.n(i);
    for (var a in i) "default" !== a && function (e) {
      s.d(t, e, function () {
        return i[e]
      })
    }(a);
    var r = s("LAyR");
    var o = function (e) {
        s("oTff")
      },
      c = s("VU/8")(n.a, r.a, !1, o, "data-v-133892a0", null);
    t.default = c.exports
  },
  oTff: function (e, t) {},
  pAjY: function (e, t, s) {
    "use strict";
    Object.defineProperty(t, "__esModule", {
      value: !0
    });
    var i = s("SmVv"),
      n = s.n(i);
    for (var a in i) "default" !== a && function (e) {
      s.d(t, e, function () {
        return i[e]
      })
    }(a);
    var r = s("uLEr");
    var o = function (e) {
        s("ypoQ")
      },
      c = s("VU/8")(n.a, r.a, !1, o, "data-v-80442fae", null);
    t.default = c.exports
  },
  qxM8: function (e, t, s) {
    "use strict";
    var i = {
      render: function () {
        var e = this,
          t = e.$createElement,
          s = e._self._c || t;
        return s("div", {
          ref: "scrollList",
          staticClass: "sc-message-list",
          style: {
            backgroundColor: e.colors.messageList.bg
          }
        }, [e._l(e.messages, function (t, i) {
          return s("Message", {
            key: i,
            attrs: {
              message: t,
              chatImageUrl: e.chatImageUrl(t.author),
              authorName: e.authorName(t.author),
              colors: e.colors
            }
          })
        }), e._v(" "), s("Message", {
          directives: [{
            name: "show",
            rawName: "v-show",
            value: "" !== e.showTypingIndicator,
            expression: "showTypingIndicator !== ''"
          }],
          attrs: {
            message: {
              author: e.showTypingIndicator,
              type: "typing"
            },
            chatImageUrl: e.chatImageUrl(e.showTypingIndicator),
            colors: e.colors
          }
        })], 2)
      },
      staticRenderFns: []
    };
    t.a = i
  },
  sHm6: function (e, t, s) {
    "use strict";
    var i = {
      render: function () {
        var e = this.$createElement;
        return (this._self._c || e)("div", {
          staticClass: "sc-message--emoji"
        }, [this._v(this._s(this.data.emoji))])
      },
      staticRenderFns: []
    };
    t.a = i
  },
  sK3v: function (e, t, s) {
    "use strict";
    Object.defineProperty(t, "__esModule", {
      value: !0
    });
    var i = a(s("PFUe")),
      n = a(s("d1QR"));

    function a(e) {
      return e && e.__esModule ? e : {
        default: e
      }
    }
    t.default = {
      components: {
        Message: i.default
      },
      props: {
        participants: {
          type: Array,
          required: !0
        },
        messages: {
          type: Array,
          required: !0
        },
        showTypingIndicator: {
          type: String,
          required: !0
        },
        colors: {
          type: Object,
          required: !0
        },
        alwaysScrollToBottom: {
          type: Boolean,
          required: !0
        }
      },
      methods: {
        _scrollDown: function () {
          this.$refs.scrollList.scrollTop = this.$refs.scrollList.scrollHeight
        },
        shouldScrollToBottom: function () {
          return this.alwaysScrollToBottom || this.$refs.scrollList.scrollTop > this.$refs.scrollList.scrollHeight - 600
        },
        profile: function (e) {
          var t = this.participants.find(function (t) {
            return t.id === e
          });
          return t || {
            imageUrl: "",
            name: ""
          }
        },
        chatImageUrl: function (e) {
          return this.profile(e).imageUrl
        },
        authorName: function (e) {
          return this.profile(e).name
        }
      },
      computed: {
        defaultChatIcon: function () {
          return n.default
        }
      },
      mounted: function () {
        this._scrollDown()
      },
      updated: function () {
        this.shouldScrollToBottom() && this.$nextTick(this._scrollDown())
      }
    }
  },
  sL4Z: function (e, t, s) {
    "use strict";
    Object.defineProperty(t, "__esModule", {
      value: !0
    });
    var i = r(s("kEJf")),
      n = r(s("aCP/")),
      a = r(s("7cnT"));

    function r(e) {
      return e && e.__esModule ? e : {
        default: e
      }
    }
    t.default = {
      components: {
        EmojiIcon: i.default,
        FileIcons: n.default,
        SendIcon: a.default
      },
      props: {
        showEmoji: {
          type: Boolean,
          default: function () {
            return !1
          }
        },
        showFile: {
          type: Boolean,
          default: function () {
            return !1
          }
        },
        onSubmit: {
          type: Function,
          required: !0
        },
        placeholder: {
          type: String,
          default: "Write a reply"
        },
        colors: {
          type: Object,
          required: !0
        }
      },
      data: function () {
        return {
          file: null,
          inputActive: !1
        }
      },
      methods: {
        cancelFile: function () {
          this.file = null
        },
        setInputActive: function (e) {
          this.inputActive = e
        },
        handleKey: function (e) {
          13 !== e.keyCode || e.shiftKey || (this._submitText(e), e.preventDefault())
        },
        _submitText: function (e) {
          var t = this.$refs.userInput.textContent,
            s = this.file;
          s ? t && t.length > 0 ? (this.onSubmit({
            author: "me",
            type: "file",
            data: {
              text: t,
              file: s
            }
          }), this.file = null, this.$refs.userInput.innerHTML = "") : (this.onSubmit({
            author: "me",
            type: "file",
            data: {
              file: s
            }
          }), this.file = null) : t && t.length > 0 && (this.onSubmit({
            author: "me",
            type: "text",
            data: {
              text: t
            }
          }), this.$refs.userInput.innerHTML = "")
        },
        _handleEmojiPicked: function (e) {
          this.onSubmit({
            author: "me",
            type: "emoji",
            data: {
              emoji: e
            }
          })
        },
        _handleFileSubmit: function (e) {
          this.file = e
        }
      }
    }
  },
  uBBs: function (e, t) {},
  uLEr: function (e, t, s) {
    "use strict";
    var i = {
      render: function () {
        var e = this,
          t = e.$createElement,
          i = e._self._c || t;
        return i("div", {
          staticClass: "sc-message--file",
          style: e.messageColors
        }, [i("div", {
          staticClass: "sc-message--file-icon"
        }, [i("a", {
          attrs: {
            href: e.data.file.url || "#",
            target: "_blank"
          }
        }, [i("img", {
          attrs: {
            src: s("w+sz"),
            alt: "generic file icon",
            height: "60"
          }
        })])]), e._v(" "), i("div", {
          staticClass: "sc-message--file-name",
          style: e.messageColors
        }, [i("a", {
          attrs: {
            href: e.data.file.url ? e.data.file.url : "#",
            target: "_blank"
          }
        }, [e._v(e._s(e.data.file.name || ""))])]), e._v(" "), i("div", {
          staticClass: "sc-message--file-text",
          style: e.messageColors
        }, [e._v(e._s(e.data.text)), e.data.meta ? i("p", {
          staticClass: "sc-message--meta",
          style: e.messageColors
        }, [e._v(e._s(e.data.meta))]) : e._e()])])
      },
      staticRenderFns: []
    };
    t.a = i
  },
  uezS: function (e, t, s) {
    "use strict";
    Object.defineProperty(t, "__esModule", {
      value: !0
    });
    var i = s("3+o7"),
      n = s.n(i);
    for (var a in i) "default" !== a && function (e) {
      s.d(t, e, function () {
        return i[e]
      })
    }(a);
    var r = s("6lTj");
    var o = function (e) {
        s("bs93")
      },
      c = s("VU/8")(n.a, r.a, !1, o, "data-v-74e6dc6c", null);
    t.default = c.exports
  },
  "w+sz": function (e, t) {
    e.exports = "data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iaXNvLTg4NTktMSI/Pgo8IS0tIEdlbmVyYXRvcjogQWRvYmUgSWxsdXN0cmF0b3IgMTguMC4wLCBTVkcgRXhwb3J0IFBsdWctSW4gLiBTVkcgVmVyc2lvbjogNi4wMCBCdWlsZCAwKSAgLS0+CjwhRE9DVFlQRSBzdmcgUFVCTElDICItLy9XM0MvL0RURCBTVkcgMS4xLy9FTiIgImh0dHA6Ly93d3cudzMub3JnL0dyYXBoaWNzL1NWRy8xLjEvRFREL3N2ZzExLmR0ZCI+CjxzdmcgdmVyc2lvbj0iMS4xIiBpZD0iQ2FwYV8xIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHhtbG5zOnhsaW5rPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hsaW5rIiB4PSIwcHgiIHk9IjBweCIKCSB2aWV3Qm94PSIwIDAgNTYgNTYiIHN0eWxlPSJlbmFibGUtYmFja2dyb3VuZDpuZXcgMCAwIDU2IDU2OyIgeG1sOnNwYWNlPSJwcmVzZXJ2ZSI+CjxnIGlkPSJzdmdfMSI+CiAgIDxwYXRoIGlkPSJzdmdfMiIgZmlsbD0iI0U5RTlFMCIgZD0ibTM2Ljk4NSwwbC0yOS4wMjIsMGMtMC44MDgsMCAtMS40NjMsMC42NTUgLTEuNDYzLDEuOTI2bDAsNTMuMDc0YzAsMC4zNDUgMC42NTUsMSAxLjQ2MywxbDQwLjA3NCwwYzAuODA4LDAgMS40NjMsLTAuNjU1IDEuNDYzLC0xbDAsLTQyLjAyMmMwLC0wLjY5NiAtMC4wOTMsLTAuOTIgLTAuMjU3LC0xLjA4NWwtMTEuNjM2LC0xMS42MzZjLTAuMTY1LC0wLjE2NCAtMC4zODksLTAuMjU3IC0wLjYyMiwtMC4yNTd6Ii8+CiAgIDxwb2x5Z29uIGlkPSJzdmdfMyIgZmlsbD0iI0Q5RDdDQSIgcG9pbnRzPSIzNy41LDAuMTUxIDM3LjUsMTIgNDkuMzQ5LDEyICAiLz4KICAgPHBhdGggaWQ9InN2Z180IiBmaWxsPSIjOTVBNUE1IiBkPSJtNDguMDM3LDU2bC00MC4wNzQsMGMtMC44MDgsMCAtMS40NjMsLTAuNjU1IC0xLjQ2MywtMS40NjNsMCwtMTUuNTM3bDQzLDBsMCwxNS41MzdjMCwwLjgwOCAtMC42NTUsMS40NjMgLTEuNDYzLDEuNDYzeiIvPgogICA8cGF0aCBpZD0ic3ZnXzkiIGZpbGw9IiNDOEJEQjgiIGQ9Im0xOC41LDEzbC02LDBjLTAuNTUzLDAgLTEsLTAuNDQ4IC0xLC0xczAuNDQ3LC0xIDEsLTFsNiwwYzAuNTUzLDAgMSwwLjQ0OCAxLDFzLTAuNDQ3LDEgLTEsMXoiLz4KICAgPHBhdGggaWQ9InN2Z18xMCIgZmlsbD0iI0M4QkRCOCIgZD0ibTIxLjUsMThsLTksMGMtMC41NTMsMCAtMSwtMC40NDggLTEsLTFzMC40NDcsLTEgMSwtMWw5LDBjMC41NTMsMCAxLDAuNDQ4IDEsMXMtMC40NDcsMSAtMSwxeiIvPgogICA8cGF0aCBpZD0ic3ZnXzExIiBmaWxsPSIjQzhCREI4IiBkPSJtMjUuNSwxOGMtMC4yNiwwIC0wLjUyMSwtMC4xMSAtMC43MSwtMC4yOWMtMC4xODEsLTAuMTkgLTAuMjksLTAuNDQgLTAuMjksLTAuNzFzMC4xMDksLTAuNTIgMC4zLC0wLjcxYzAuMzYsLTAuMzcgMS4wNCwtMC4zNyAxLjQxLDBjMC4xOCwwLjE5IDAuMjksMC40NSAwLjI5LDAuNzFjMCwwLjI2IC0wLjExLDAuNTIgLTAuMjksMC43MWMtMC4xOSwwLjE4IC0wLjQ1LDAuMjkgLTAuNzEsMC4yOXoiLz4KICAgPHBhdGggaWQ9InN2Z18xMiIgZmlsbD0iI0M4QkRCOCIgZD0ibTM3LjUsMThsLTgsMGMtMC41NTMsMCAtMSwtMC40NDggLTEsLTFzMC40NDcsLTEgMSwtMWw4LDBjMC41NTMsMCAxLDAuNDQ4IDEsMXMtMC40NDcsMSAtMSwxeiIvPgogICA8cGF0aCBpZD0ic3ZnXzEzIiBmaWxsPSIjQzhCREI4IiBkPSJtMTIuNSwzM2MtMC4yNiwwIC0wLjUyMSwtMC4xMSAtMC43MSwtMC4yOWMtMC4xODEsLTAuMTkgLTAuMjksLTAuNDUgLTAuMjksLTAuNzFjMCwtMC4yNiAwLjEwOSwtMC41MiAwLjI5LC0wLjcxYzAuMzcsLTAuMzcgMS4wNSwtMC4zNyAxLjQyLDAuMDFjMC4xOCwwLjE4IDAuMjksMC40NCAwLjI5LDAuN2MwLDAuMjYgLTAuMTEsMC41MiAtMC4yOSwwLjcxYy0wLjE5LDAuMTggLTAuNDUsMC4yOSAtMC43MSwwLjI5eiIvPgogICA8cGF0aCBpZD0ic3ZnXzE0IiBmaWxsPSIjQzhCREI4IiBkPSJtMjQuNSwzM2wtOCwwYy0wLjU1MywwIC0xLC0wLjQ0OCAtMSwtMXMwLjQ0NywtMSAxLC0xbDgsMGMwLjU1MywwIDEsMC40NDggMSwxcy0wLjQ0NywxIC0xLDF6Ii8+CiAgIDxwYXRoIGlkPSJzdmdfMTUiIGZpbGw9IiNDOEJEQjgiIGQ9Im00My41LDE4bC0yLDBjLTAuNTUzLDAgLTEsLTAuNDQ4IC0xLC0xczAuNDQ3LC0xIDEsLTFsMiwwYzAuNTUzLDAgMSwwLjQ0OCAxLDFzLTAuNDQ3LDEgLTEsMXoiLz4KICAgPHBhdGggaWQ9InN2Z18xNiIgZmlsbD0iI0M4QkRCOCIgZD0ibTM0LjUsMjNsLTIyLDBjLTAuNTUzLDAgLTEsLTAuNDQ4IC0xLC0xczAuNDQ3LC0xIDEsLTFsMjIsMGMwLjU1MywwIDEsMC40NDggMSwxcy0wLjQ0NywxIC0xLDF6Ii8+CiAgIDxwYXRoIGlkPSJzdmdfMTciIGZpbGw9IiNDOEJEQjgiIGQ9Im00My41LDIzbC02LDBjLTAuNTUzLDAgLTEsLTAuNDQ4IC0xLC0xczAuNDQ3LC0xIDEsLTFsNiwwYzAuNTUzLDAgMSwwLjQ0OCAxLDFzLTAuNDQ3LDEgLTEsMXoiLz4KICAgPHBhdGggaWQ9InN2Z18xOCIgZmlsbD0iI0M4QkRCOCIgZD0ibTE2LjUsMjhsLTQsMGMtMC41NTMsMCAtMSwtMC40NDggLTEsLTFzMC40NDcsLTEgMSwtMWw0LDBjMC41NTMsMCAxLDAuNDQ4IDEsMXMtMC40NDcsMSAtMSwxeiIvPgogICA8cGF0aCBpZD0ic3ZnXzE5IiBmaWxsPSIjQzhCREI4IiBkPSJtMzAuNSwyOGwtMTAsMGMtMC41NTMsMCAtMSwtMC40NDggLTEsLTFzMC40NDcsLTEgMSwtMWwxMCwwYzAuNTUzLDAgMSwwLjQ0OCAxLDFzLTAuNDQ3LDEgLTEsMXoiLz4KICAgPHBhdGggaWQ9InN2Z18yMCIgZmlsbD0iI0M4QkRCOCIgZD0ibTQzLjUsMjhsLTksMGMtMC41NTMsMCAtMSwtMC40NDggLTEsLTFzMC40NDcsLTEgMSwtMWw5LDBjMC41NTMsMCAxLDAuNDQ4IDEsMXMtMC40NDcsMSAtMSwxeiIvPgogIDwvZz4KICA8ZyBpZD0ic3ZnXzIxIi8+CiAgPGcgaWQ9InN2Z18yMiIvPgogIDxnIGlkPSJzdmdfMjMiLz4KICA8ZyBpZD0ic3ZnXzI0Ii8+CiAgPGcgaWQ9InN2Z18yNSIvPgogIDxnIGlkPSJzdmdfMjYiLz4KICA8ZyBpZD0ic3ZnXzI3Ii8+CiAgPGcgaWQ9InN2Z18yOCIvPgogIDxnIGlkPSJzdmdfMjkiLz4KICA8ZyBpZD0ic3ZnXzMwIi8+CiAgPGcgaWQ9InN2Z18zMSIvPgogIDxnIGlkPSJzdmdfMzIiLz4KICA8ZyBpZD0ic3ZnXzMzIi8+CiAgPGcgaWQ9InN2Z18zNCIvPgogIDxnIGlkPSJzdmdfMzUiLz4KPC9zdmc+"
  },
  wyO6: function (e, t, s) {
    "use strict";
    Object.defineProperty(t, "__esModule", {
      value: !0
    });
    var i = s("sK3v"),
      n = s.n(i);
    for (var a in i) "default" !== a && function (e) {
      s.d(t, e, function () {
        return i[e]
      })
    }(a);
    var r = s("qxM8");
    var o = function (e) {
        s("nZPl")
      },
      c = s("VU/8")(n.a, r.a, !1, o, "data-v-f90e5364", null);
    t.default = c.exports
  },
  "xc3+": function (e, t) {
    e.exports = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAfCAMAAACxiD++AAAABGdBTUEAALGPC/xhBQAAAAFzUkdCAK7OHOkAAAAtUExURUxpcf///////////////////////////////////////////////////////3EAnbYAAAAOdFJOUwADZ66SoQjEhnS7/gsNGQL7+wAAAKtJREFUKM+F01sOhCAQRNESFV/I/pc70Og0YJfyJbmHhBAbGGYHstw8IPV4EOGOmERYIhGpxyUAJxHSz/xlC+1FxE64qB1yj1ZID7oXsel+63ovnj2JXUXue+hvrcLugL+EdG+9XBG8X+Kl34J3YM1g/egvIvdx5EK691RIz78YEXdnQrst6m6JqemXmNo+D/WJNAyVePZWWL0WdlfB+l+UAQQReaAc65DB/wGsZgzLN0IQWAAAAABJRU5ErkJggg=="
  },
  xemH: function (e, t, s) {
    "use strict";
    Object.defineProperty(t, "__esModule", {
      value: !0
    });
    var i = s("yCuV"),
      n = s.n(i);
    for (var a in i) "default" !== a && function (e) {
      s.d(t, e, function () {
        return i[e]
      })
    }(a);
    var r = s("sHm6");
    var o = function (e) {
        s("Nkf6")
      },
      c = s("VU/8")(n.a, r.a, !1, o, "data-v-dcc5aba6", null);
    t.default = c.exports
  },
  "y1+y": function (e, t, s) {
    "use strict";
    var i = s("jSRS"),
      n = s.n(i),
      a = s("kl68");
    var r = function (e) {
        s("lwox")
      },
      o = s("VU/8")(n.a, a.a, !1, r, "data-v-5669e46e", null);
    t.default = o.exports
  },
  yCuV: function (e, t, s) {
    "use strict";
    Object.defineProperty(t, "__esModule", {
      value: !0
    }), t.default = {
      props: {
        data: {
          type: Object,
          required: !0
        }
      }
    }
  },
  ypoQ: function (e, t) {}
}, ["NHnr"]);
//# sourceMappingURL=app.3dc4e29ad1b7218a607c.js.map
