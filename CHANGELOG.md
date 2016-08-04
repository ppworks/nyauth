## v0.7.2

* Mailer sender setting. #84

## v0.7.1

* Refactor #81, #82

## v0.7.0

* Nyauth::BaseController extends ActionController::Base

## v0.6.2

* Fix bug. #73

## v0.6.1

* Fix bug. #71

## v0.6.0

* Support cookie auth. #69

## v0.5.0

* Remove deprecated methods. #58
* Mailer delivery method setting. #59
  * `config.config.mail_delivery_method = :deliver_now`
* Tweak views #61, #62
* Fix bugs.
  * Store return_to path when not signed in. #64

## v0.4.0

* Refactor #55, #56, #57
  * Change parameter name. Please re-create views. `rails g nyauth:views`

## v0.3.0

* Refactor #54
  * client_class & client_name is deprecated. Use nyauth_client_class & nyauth_client_name.
* Tweak redirect paeg after sign in #53

## v0.2.8

* Description typo.
* Don't use alias_method_chain. #46

## v0.2.7

* Support Rails 5.0.0.alpha #44
* Use Nyauth::AppResponder in nyauth controller. #43

## v0.2.6

* Add test helper. #42

## v0.2.5

* Fix bug. #41

## v0.2.4

* Fix bug. #39

## v0.2.3

* Tweak I18n files. #30, #37
* Refactor. #36

## v0.2.2

* Migration generator `rails g nyauth <MODEL>`. #25, #26
* Improve configuration. #28
* Fix bugs. #27


## v0.2.1

* Refactor model concerns. #24

## v0.2.0

* Reduce RUNTIME DEPENDENCIES. #17, #18, #22
* Using routing concerns. #24
* Views generator `rails g nyauth:views` #20


## v0.1.0

* Change reset password URL.
* Change column name for reset password URL.

## v0.0.3

* Support multiple rosource authentication.
