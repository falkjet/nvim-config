(local watch-processes {})

(fn start-watch-process [path]
    (let [command (: "typst watch %s" :format (vim.fn.shellescape path))
          jobid (vim.fn.jobstart
                  command
                  {:on_exit (fn [] (tset watch-processes path nil))})]

      (when (not= jobid 0)
        (tset watch-processes path jobid))))

(fn run-file [path]
    (let [typst-file (or path (vim.fn.expand "%:p"))]
      (when (not (. watch-processes typst-file)) (start-watch-process typst-file))))

(fn view-file [path retry-count retry-delay]
    (set-forcibly! retry-count (or retry-count 10))
    (set-forcibly! retry-delay (* (or retry-delay 50) 2))
    (local pdf-file (or path (.. (vim.fn.expand "%:p:r") :.pdf)))
    (local open-command (: "xdg-open %s" :format (vim.fn.shellescape pdf-file)))
    (fn on-exit [_ code]
        (when (and (not= code 0) (> retry-count 0))
          (vim.defer_fn (fn [] (view-file path (- retry-count 1))) 300)))
    (vim.fn.jobstart open-command
                     {:detach true
                     :on_exit on-exit}))

{: run-file :run_file run-file
 : view-file :view_file view-file}
