//
//  TestTypes.swift
//  Branch Builder
//
//  Created by Lucas Rose on 7/12/16.
//  Copyright © 2016 Lucas Rose. All rights reserved.
//

import Foundation

enum TestType: String {
    case LINT_COMPILE = "LINT-COMPILE"
    case PYTHON = "PYTHON"
    case RUBY_LINT = "RUBY-LINT"
    case UNIT_INTEGRATION = "UNIT INTEGRATION"
    case BRANCH_ACCEPTANCE = "BRANCH ACCEPTANCE"
    case DIST = "DIST"
}
