# Gmail API Parameter Reference

## Messages

### List Messages

```
GET /gmail/v1/users/me/messages
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `maxResults` | integer | Maximum messages to return (default: 100, max: 500) |
| `q` | string | Gmail search query (same syntax as Gmail search box) |
| `labelIds` | string[] | Only return messages with these label IDs |
| `pageToken` | string | Page token for pagination |
| `includeSpamTrash` | boolean | Include SPAM and TRASH (default: false) |

### Get Message

```
GET /gmail/v1/users/me/messages/{id}
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `id` | string | Message ID |
| `format` | string | `full` (default), `metadata`, `minimal`, `raw` |
| `metadataHeaders` | string[] | Headers to include when format=metadata |

### Send Message

```
POST /gmail/v1/users/me/messages/send
```

| Field | Type | Description |
|-------|------|-------------|
| `raw` | string | Base64url-encoded RFC 2822 email |
| `threadId` | string | Thread ID for replies |

### Modify Message

```
POST /gmail/v1/users/me/messages/{id}/modify
```

| Field | Type | Description |
|-------|------|-------------|
| `addLabelIds` | string[] | Label IDs to add |
| `removeLabelIds` | string[] | Label IDs to remove |

### Trash / Untrash

```
POST /gmail/v1/users/me/messages/{id}/trash
POST /gmail/v1/users/me/messages/{id}/untrash
```

## Threads

### List Threads

```
GET /gmail/v1/users/me/threads
```

Same parameters as List Messages.

### Get Thread

```
GET /gmail/v1/users/me/threads/{id}
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `id` | string | Thread ID |
| `format` | string | `full` (default), `metadata`, `minimal` |

## Labels

### List Labels

```
GET /gmail/v1/users/me/labels
```

### Common Label IDs

- `INBOX` — Inbox
- `SENT` — Sent Mail
- `DRAFT` — Drafts
- `STARRED` — Starred
- `UNREAD` — Unread
- `TRASH` — Trash
- `SPAM` — Spam
- `IMPORTANT` — Important
- `CATEGORY_PERSONAL` — Primary tab
- `CATEGORY_SOCIAL` — Social tab
- `CATEGORY_PROMOTIONS` — Promotions tab
- `CATEGORY_UPDATES` — Updates tab

## Drafts

### Create Draft

```
POST /gmail/v1/users/me/drafts
```

| Field | Type | Description |
|-------|------|-------------|
| `message.raw` | string | Base64url-encoded RFC 2822 email |

### Send Draft

```
POST /gmail/v1/users/me/drafts/send
```

| Field | Type | Description |
|-------|------|-------------|
| `id` | string | Draft ID |

## Profile

```
GET /gmail/v1/users/me/profile
```

Returns: `emailAddress`, `messagesTotal`, `threadsTotal`, `historyId`

## Query Operators

| Operator | Example | Description |
|----------|---------|-------------|
| `from:` | `from:user@example.com` | From sender |
| `to:` | `to:user@example.com` | To recipient |
| `subject:` | `subject:meeting` | Subject contains |
| `is:` | `is:unread`, `is:starred` | Message state |
| `has:` | `has:attachment` | Has attachment |
| `after:` | `after:2026/01/01` | After date |
| `before:` | `before:2026/12/31` | Before date |
| `label:` | `label:work` | Has label |
| `in:` | `in:inbox`, `in:sent` | In location |
| `filename:` | `filename:pdf` | Attachment filename |
| `larger:` | `larger:5M` | Larger than size |
| `smaller:` | `smaller:1M` | Smaller than size |

## Resources

- [Gmail API Reference](https://developers.google.com/gmail/api/reference/rest)
- [Gmail Search Operators](https://support.google.com/mail/answer/7190)
- [OAuth 2.0 for Desktop Apps](https://developers.google.com/identity/protocols/oauth2/native-app)
