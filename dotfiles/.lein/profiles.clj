{:auth {:repository-auth {#"clojars" {:username :gpg :password :gpg}}}
 :user {:plugins [[lein-pprint "1.2.0"]
                  [lein-auto "0.1.3"]
                  [lein-cljfmt "0.5.7" :exclusions [org.clojure/clojure]]
                  [lein-ancient "0.6.14"]
                  [lein-project-deps "0.3.0"]
                  [lein-cloverage "1.0.10" :exclusions [org.clojure/clojure]]
                  [jonase/eastwood "0.2.5" :exclusions [org.clojure/clojure]]
                  [lein-kibit "0.1.6" :exclusions [org.clojure/clojure
                                                   org.clojure/tools.namespace
                                                   org.clojure/tools.reader]]
                  [lein-codox "0.10.3"]]
        :cljfmt {:file-pattern #"\.clj[cs]?$"
                 ; see https://git.io/vS6QP for cljfmt defaults
                 :indents {; parsatron
                           let->> [[:inner 0]]
                           choice [[:block 0]]
                           many   [[:block 0]]
                           peok   [[:inner 0]]
                           perr   [[:inner 0]]
                           ; manifold
                           #"^extend-" [[:block 1] [:inner 1]] ; same as extend-protocol
                           ; overrides
                           element  [[:inner 0]]
                           lazy-seq [[:inner 0]]
                           doto ^:replace [[:block 0]]}}
        :dependencies [[org.clojure/tools.namespace "0.3.0-alpha4"]
                       [org.clojure/tools.reader "1.1.1"]
                       [slamhound "1.5.5"]
                       ; https://github.com/pallet/alembic for live classloading:
                       ; e.g.: (require '[alembic.still :refer [distill]])
                       ;       (distill '[org.clojure/tools.namespace "0.3.0-alpha4"])
                       ;       (require '[clojure.tools.namespace.repl :refer [refresh refresh-all]])
                       [alembic "0.3.2"]
                       [chbrown/humane-test-output "0.8.3"]]
        :aliases {"slamhound" ["run" "-m" "slam.hound"]}
        :global-vars {*print-length* 50} ; same as: {:repl-options {:init (set! *print-length* 50)}}
        :injections [(require 'humane-test-output.core)
                     (humane-test-output.core/activate!)
                     (require '[clojure.tools.namespace.repl :refer [refresh refresh-all]])]}}
