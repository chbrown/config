{:auth {:repository-auth {#"clojars" {:username :gpg :password :gpg}}}
 :user {:plugins [[lein-pprint "1.2.0"]
                  [lein-auto "0.1.3"]
                  [lein-cljfmt "0.5.7" :exclusions [org.clojure/clojure]]
                  [lein-nsorg "0.2.0"]
                  [lein-ancient "0.6.15"]
                  [lein-project-deps "0.3.0"]
                  [lein-cloverage "1.0.11" :exclusions [org.clojure/clojure]]
                  [jonase/eastwood "0.2.8" :exclusions [org.clojure/clojure]]
                  [lein-kibit "0.1.6" :exclusions [org.clojure/clojure
                                                   org.clojure/tools.namespace
                                                   org.clojure/tools.reader]]
                  [lein-codox "0.10.4"]]
        :cljfmt {:file-pattern #"\.clj[cs]?$"
                 ; Inner rules:
                 ; - Syntax: [:inner <n-spaces>] [:inner <n-spaces> <arg-index>]
                 ;   * All subforms (arguments after the first symbol in the list, i.e., the function being called)
                 ;     on new lines will be indented by 1 or 2 space characters.
                 ;   * If <arg-index> is provided (rare), only apply the rule to the subform at that index
                 ; [:inner 0] => indents all subforms at 2 spaces
                 ; [:inner 1] => indents all subforms at 1 space
                 ; [:inner 2 0] => only apply 2-space indentation to the first subform
                 ; Block rules:
                 ; - Syntax: [:block <start>]
                 ;   * Subforms will left-aligned with the subform at index <start>
                 ;     (iff that subform remains on the first line of the form)
                 ; [:block 0] => indents all subforms to align with the first
                 ;               (e.g., cond, do, try)
                 ;               this primarily makes sense for arglists with only varargs, i.e., [& forms]
                 ; [:block 1] => indents the third, fourth, (and so on) subforms to align with the second
                 ;               (e.g., case, cond->, defprotocol, if, ... a.o.)
                 ;               this makes most sense for an arglist like [main-arg & more]
                 ; [:block 2] => indents the subforms after the third to align with the third
                 ;               (e.g., catch, condp)
                 ;               this makes most sense for an arglist like [main-arg second-main-arg & more]
                 ; see https://git.io/vS6QP for cljfmt defaults
                 :indents {; parsatron
                           let->> [[:inner 0]]
                           choice [[:block 0]]
                           many   [[:block 0]]
                           peok   [[:inner 0]]
                           perr   [[:inner 0]]
                           ; manifold
                           #"^extend-" [[:block 1] [:inner 1]] ; same as extend-protocol
                           ; spec
                           fdef [[:inner 0]]
                           ; overrides
                           assoc [[:block 1]] ; doesn't work as intended, due to the doubling of key+val subforms
                           element  [[:inner 0]]
                           lazy-seq [[:inner 0]]
                           thrown-with-msg? [[:inner 0]]
                           are ^:replace [[:block 0]]
                           doto ^:replace [[:block 0]]}}
        :dependencies [[org.clojure/tools.namespace "0.3.0-alpha4"]
                       [org.clojure/tools.reader "1.3.0"]
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
