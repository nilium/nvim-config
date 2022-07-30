(local {: string?} (require :com))

(lambda config [name ?config]
  (let [pkg (require name)]
    (pkg.setup (or ?config []))))

(fn configure [def key value ...]
  (match (values key value)
    ; Done:
    (nil _) def
    ; Regular key-value pair:
    _ (doto def (tset key value) (configure ...))))

(lambda plugin [name ...]
  (configure [name] ...))

; Hack: make global Plugin table to work around the fact that packer.nvim uses
; string.dump, which in turn drops upvalues. So, you cannot really program
; around packer's config field.
(set _G.Plugin {: config})

{: plugin}
