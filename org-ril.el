(require 'json)

(defvar url-http-end-of-headers)

(defun org-ril-gen-api-url (req params)
  (read-from-minibuffer "Check URL: "  
	 (concat "https://readitlaterlist.com/v2/" req "?"
		 (mapconcat '(lambda (tpl) 
			       (concat (symbol-name (car tpl)) "=" (cadr tpl)))
			    params "&")
		 )))

(defun org-ril-authenticate (user pass apikey)
  (interactive)
  (with-current-buffer 
      ; TODO check status
      (url-retrieve-synchronously 
       (org-ril-gen-api-url "auth" `((username ,user) (pass ,pass) (apikey ,apikey))))))

(defun org-ril-get-list (user pass apikey since)
  (interactive)
  (with-current-buffer 
    (url-retrieve-synchronously 
     (org-ril-gen-api-url "auth" `((username ,user) (pass ,pass) (apikey ,apikey) (since ,since))))
    (goto-char url-http-end-of-headers)
    (json-read)))

(provide 'org-ril)
