(var job-id nil)
(var port nil)

(fn on-exit [id status event]
  (set job-id nil)
  (set port nil))

(fn start []
  (when (= port nil)
    (set port (math.floor (+ (* (math.random) (- 65535 1024)) 1024)))
    (local command (: "live-server --no-browser --port=%d" :format port))

    (set job-id (vim.fn.jobstart command {:on_exit on-exit}))
    (print job-id)))

(fn open [filename]
  (local filepath (if (= filename nil) (vim.fn.expand :%) filename))
  (start)
  (print (vim.inspect filepath))
  (vim.fn.jobstart [:xdg-open
                    (: "http://localhost:%d/%s" :format port filepath)]))

{: start : open}
