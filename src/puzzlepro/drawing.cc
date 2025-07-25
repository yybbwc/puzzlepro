
namespace ygo {

  void Game::DrawSelectionLine(irr::video::S3DVertex *vec, bool strip, int width, float *cv) {
    if (!gameConf.use_d3d) {
      float origin[4] = {1.0f, 1.0f, 1.0f, 1.0f};
      glLineWidth(width);
      glLineStipple(1, linePatternGL);
      if (strip) {
        glEnable(GL_LINE_STIPPLE);
      }
      glDisable(GL_TEXTURE_2D);
      glMaterialfv(GL_FRONT, GL_AMBIENT, cv);
      glBegin(GL_LINE_LOOP);
      glVertex3fv(&vec[0].Pos.X);
      glVertex3fv(&vec[1].Pos.X);
      glVertex3fv(&vec[3].Pos.X);
      glVertex3fv(&vec[2].Pos.X);
      glEnd();
      glMaterialfv(GL_FRONT, GL_AMBIENT, origin);
      glDisable(GL_LINE_STIPPLE);
      glEnable(GL_TEXTURE_2D);
    }
    //~ else {
    //~ driver->setMaterial(matManager.mOutLine);
    //~ if (strip) {
    //~ if (linePatternD3D < 15) {
    //~ driver->draw3DLine(vec[0].Pos, vec[0].Pos + (vec[1].Pos - vec[0].Pos) * (linePatternD3D + 1) / 15.0);
    //~ driver->draw3DLine(vec[1].Pos, vec[1].Pos + (vec[3].Pos - vec[1].Pos) * (linePatternD3D + 1) / 15.0);
    //~ driver->draw3DLine(vec[3].Pos, vec[3].Pos + (vec[2].Pos - vec[3].Pos) * (linePatternD3D + 1) / 15.0);
    //~ driver->draw3DLine(vec[2].Pos, vec[2].Pos + (vec[0].Pos - vec[2].Pos) * (linePatternD3D + 1) / 15.0);
    //~ }
    //~ else {
    //~ driver->draw3DLine(vec[0].Pos + (vec[1].Pos - vec[0].Pos) * (linePatternD3D - 14) / 15.0, vec[1].Pos);
    //~ driver->draw3DLine(vec[1].Pos + (vec[3].Pos - vec[1].Pos) * (linePatternD3D - 14) / 15.0, vec[3].Pos);
    //~ driver->draw3DLine(vec[3].Pos + (vec[2].Pos - vec[3].Pos) * (linePatternD3D - 14) / 15.0, vec[2].Pos);
    //~ driver->draw3DLine(vec[2].Pos + (vec[0].Pos - vec[2].Pos) * (linePatternD3D - 14) / 15.0, vec[0].Pos);
    //~ }
    //~ }
    //~ else {
    //~ driver->draw3DLine(vec[0].Pos, vec[1].Pos);
    //~ driver->draw3DLine(vec[1].Pos, vec[3].Pos);
    //~ driver->draw3DLine(vec[3].Pos, vec[2].Pos);
    //~ driver->draw3DLine(vec[2].Pos, vec[0].Pos);
    //~ }
    //~ }
  }

  //~ void Game::DrawSelectionLine(irr::gui::IGUIElement *element, int width, irr::video::SColor color) {
  //~ irr::core::recti pos = element->getAbsolutePosition();
  //~ float x1 = pos.UpperLeftCorner.X;
  //~ float x2 = pos.LowerRightCorner.X;
  //~ float y1 = pos.UpperLeftCorner.Y;
  //~ float y2 = pos.LowerRightCorner.Y;
  //~ float w = pos.getWidth();
  //~ float h = pos.getHeight();
  //~ if (linePatternD3D < 15) {
  //~ driver->draw2DRectangle(color, irr::core::recti(x1 - 1 - width, y1 - 1 - width, x1 + (w * (linePatternD3D + 1) / 15.0) + 1 + width, y1 - 1));
  //~ driver->draw2DRectangle(color, irr::core::recti(x2 - (w * (linePatternD3D + 1) / 15.0) - 1 - width, y2 + 1, x2 + 1 + width, y2 + 1 + width));
  //~ driver->draw2DRectangle(color, irr::core::recti(x1 - 1 - width, y1 - 1 - width, x1 - 1, y2 - (h * (linePatternD3D + 1) / 15.0) + 1 + width));
  //~ driver->draw2DRectangle(color, irr::core::recti(x2 + 1, y1 + (h * (linePatternD3D + 1) / 15.0) - 1 - width, x2 + 1 + width, y2 + 1 + width));
  //~ }
  //~ else {
  //~ driver->draw2DRectangle(color, irr::core::recti(x1 - 1 - width + (w * (linePatternD3D - 14) / 15.0), y1 - 1 - width, x2 + 1 + width, y1 - 1));
  //~ driver->draw2DRectangle(color, irr::core::recti(x1 - 1 - width, y2 + 1, x2 - (w * (linePatternD3D - 14) / 15.0) + 1 + width, y2 + 1 + width));
  //~ driver->draw2DRectangle(color, irr::core::recti(x1 - 1 - width, y2 - (h * (linePatternD3D - 14) / 15.0) - 1 - width, x1 - 1, y2 + 1 + width));
  //~ driver->draw2DRectangle(color, irr::core::recti(x2 + 1, y1 - 1 - width, x2 + 1 + width, y1 + (h * (linePatternD3D - 14) / 15.0) + 1 + width));
  //~ }
  //~ }

  void Game::DrawBackGround() {
    static int selFieldAlpha = 255;
    static int selFieldDAlpha = -10;
    driver->setTransform(irr::video::ETS_WORLD, irr::core::IdentityMatrix);
    bool drawField = false;
    int rule = (dInfo.duel_rule >= 4) ? 1 : 0;
    if (gameConf.draw_field_spell) {
      int fieldcode1 = -1;
      int fieldcode2 = -1;
      if (dField.szone[0][5] && dField.szone[0][5]->position & POS_FACEUP) {
        fieldcode1 = dField.szone[0][5]->code;
      }
      if (dField.szone[1][5] && dField.szone[1][5]->position & POS_FACEUP) {
        fieldcode2 = dField.szone[1][5]->code;
      }
      int fieldcode = (fieldcode1 > 0) ? fieldcode1 : fieldcode2;
      if (fieldcode1 > 0 && fieldcode2 > 0 && fieldcode1 != fieldcode2) {
        irr::video::ITexture *texture = imageManager.GetTextureField(fieldcode1);
        if (texture) {
          drawField = true;
          matManager.mTexture.setTexture(0, texture);
          driver->setMaterial(matManager.mTexture);
          driver->drawVertexPrimitiveList(matManager.vFieldSpell1, 4, matManager.iRectangle, 2);
        }
        texture = imageManager.GetTextureField(fieldcode2);
        if (texture) {
          drawField = true;
          matManager.mTexture.setTexture(0, texture);
          driver->setMaterial(matManager.mTexture);
          driver->drawVertexPrimitiveList(matManager.vFieldSpell2, 4, matManager.iRectangle, 2);
        }
      }
      else if (fieldcode > 0) {
        irr::video::ITexture *texture = imageManager.GetTextureField(fieldcode);
        if (texture) {
          drawField = true;
          matManager.mTexture.setTexture(0, texture);
          driver->setMaterial(matManager.mTexture);
          driver->drawVertexPrimitiveList(matManager.vFieldSpell, 4, matManager.iRectangle, 2);
        }
      }
    }
    matManager.mTexture.setTexture(0, drawField ? imageManager.tFieldTransparent[rule] : imageManager.tField[rule]);
    driver->setMaterial(matManager.mTexture);
    driver->drawVertexPrimitiveList(matManager.vField, 4, matManager.iRectangle, 2);
    driver->setMaterial(matManager.mBackLine);
    // select field
    if (dInfo.curMsg == MSG_SELECT_PLACE || dInfo.curMsg == MSG_SELECT_DISFIELD || dInfo.curMsg == MSG_HINT) {
      float cv[4] = {0.0f, 0.0f, 1.0f, 1.0f};
      unsigned int filter = 0x1;
      for (int i = 0; i < 7; ++i, filter <<= 1) {
        if (dField.selectable_field & filter) {
          DrawSelectionLine(matManager.vFieldMzone[0][i], !(dField.selected_field & filter), 2, cv);
        }
      }
      filter = 0x100;
      for (int i = 0; i < 8; ++i, filter <<= 1) {
        if (dField.selectable_field & filter) {
          DrawSelectionLine(matManager.vFieldSzone[0][i][rule], !(dField.selected_field & filter), 2, cv);
        }
      }
      filter = 0x10000;
      for (int i = 0; i < 7; ++i, filter <<= 1) {
        if (dField.selectable_field & filter) {
          DrawSelectionLine(matManager.vFieldMzone[1][i], !(dField.selected_field & filter), 2, cv);
        }
      }
      filter = 0x1000000;
      for (int i = 0; i < 8; ++i, filter <<= 1) {
        if (dField.selectable_field & filter) {
          DrawSelectionLine(matManager.vFieldSzone[1][i][rule], !(dField.selected_field & filter), 2, cv);
        }
      }
    }
    // disabled field
    {
      /*float cv[4] = {0.0f, 0.0f, 1.0f, 1.0f};*/
      unsigned int filter = 0x1;
      for (int i = 0; i < 7; ++i, filter <<= 1) {
        if (dField.disabled_field & filter) {
          driver->draw3DLine(matManager.vFieldMzone[0][i][0].Pos, matManager.vFieldMzone[0][i][3].Pos, 0xffffffff);
          driver->draw3DLine(matManager.vFieldMzone[0][i][1].Pos, matManager.vFieldMzone[0][i][2].Pos, 0xffffffff);
        }
      }
      filter = 0x100;
      for (int i = 0; i < 8; ++i, filter <<= 1) {
        if (dField.disabled_field & filter) {
          driver->draw3DLine(matManager.vFieldSzone[0][i][rule][0].Pos, matManager.vFieldSzone[0][i][rule][3].Pos, 0xffffffff);
          driver->draw3DLine(matManager.vFieldSzone[0][i][rule][1].Pos, matManager.vFieldSzone[0][i][rule][2].Pos, 0xffffffff);
        }
      }
      filter = 0x10000;
      for (int i = 0; i < 7; ++i, filter <<= 1) {
        if (dField.disabled_field & filter) {
          driver->draw3DLine(matManager.vFieldMzone[1][i][0].Pos, matManager.vFieldMzone[1][i][3].Pos, 0xffffffff);
          driver->draw3DLine(matManager.vFieldMzone[1][i][1].Pos, matManager.vFieldMzone[1][i][2].Pos, 0xffffffff);
        }
      }
      filter = 0x1000000;
      for (int i = 0; i < 8; ++i, filter <<= 1) {
        if (dField.disabled_field & filter) {
          driver->draw3DLine(matManager.vFieldSzone[1][i][rule][0].Pos, matManager.vFieldSzone[1][i][rule][3].Pos, 0xffffffff);
          driver->draw3DLine(matManager.vFieldSzone[1][i][rule][1].Pos, matManager.vFieldSzone[1][i][rule][2].Pos, 0xffffffff);
        }
      }
    }
    // current sel
    if (dField.hovered_location != 0 && dField.hovered_location != 2 && dField.hovered_location != POSITION_HINT && (dInfo.duel_rule >= 4 || dField.hovered_location != LOCATION_MZONE || dField.hovered_sequence <= 4) && (dInfo.duel_rule < 4 || dField.hovered_location != LOCATION_SZONE || dField.hovered_sequence <= 5)) {
      irr::video::S3DVertex *vertex = nullptr;
      if (dField.hovered_location == LOCATION_DECK) {
        vertex = matManager.vFieldDeck[dField.hovered_controler];
      }
      else if (dField.hovered_location == LOCATION_MZONE) {
        vertex = matManager.vFieldMzone[dField.hovered_controler][dField.hovered_sequence];
        ClientCard *pcard = dField.mzone[dField.hovered_controler][dField.hovered_sequence];
        if (pcard && pcard->type & TYPE_LINK) {
          DrawLinkedZones(pcard);
        }
      }
      else if (dField.hovered_location == LOCATION_SZONE) {
        vertex = matManager.vFieldSzone[dField.hovered_controler][dField.hovered_sequence][rule];
      }
      else if (dField.hovered_location == LOCATION_GRAVE) {
        vertex = matManager.vFieldGrave[dField.hovered_controler][rule];
      }
      else if (dField.hovered_location == LOCATION_REMOVED) {
        vertex = matManager.vFieldRemove[dField.hovered_controler][rule];
      }
      else if (dField.hovered_location == LOCATION_EXTRA) {
        vertex = matManager.vFieldExtra[dField.hovered_controler];
      }
      selFieldAlpha += selFieldDAlpha;
      if (selFieldAlpha <= 5) {
        selFieldAlpha = 5;
        selFieldDAlpha = 10;
      }
      if (selFieldAlpha >= 205) {
        selFieldAlpha = 205;
        selFieldDAlpha = -10;
      }
      matManager.mSelField.AmbientColor = 0xffffffff;
      matManager.mSelField.DiffuseColor = selFieldAlpha << 24;
      driver->setMaterial(matManager.mSelField);
      driver->drawVertexPrimitiveList(vertex, 4, matManager.iRectangle, 2);
    }
  }

  void Game::DrawLinkedZones(ClientCard *pcard) {
    auto mark = pcard->link_marker;
    ClientCard *pcard2 = nullptr;
    if (dField.hovered_sequence < 5) {
      if (mark & LINK_MARKER_LEFT && dField.hovered_sequence > 0) {
        pcard2 = dField.mzone[dField.hovered_controler][dField.hovered_sequence - 1];
        CheckMutual(pcard2, LINK_MARKER_RIGHT);
        driver->drawVertexPrimitiveList(&matManager.vFieldMzone[dField.hovered_controler][dField.hovered_sequence - 1], 4, matManager.iRectangle, 2);
      }
      if (mark & LINK_MARKER_RIGHT && dField.hovered_sequence < 4) {
        pcard2 = dField.mzone[dField.hovered_controler][dField.hovered_sequence + 1];
        CheckMutual(pcard2, LINK_MARKER_LEFT);
        driver->drawVertexPrimitiveList(&matManager.vFieldMzone[dField.hovered_controler][dField.hovered_sequence + 1], 4, matManager.iRectangle, 2);
      }
      if (dInfo.duel_rule >= 4) {
        if ((mark & LINK_MARKER_TOP_LEFT && dField.hovered_sequence == 2) || (mark & LINK_MARKER_TOP && dField.hovered_sequence == 1) || (mark & LINK_MARKER_TOP_RIGHT && dField.hovered_sequence == 0)) {
          int arrow = (dField.hovered_sequence == 2) ? LINK_MARKER_BOTTOM_RIGHT : (dField.hovered_sequence == 1) ? LINK_MARKER_BOTTOM : LINK_MARKER_BOTTOM_LEFT;
          pcard2 = dField.mzone[dField.hovered_controler][5];
          if (!pcard2) {
            pcard2 = dField.mzone[1 - dField.hovered_controler][6];
            arrow = (dField.hovered_sequence == 2) ? LINK_MARKER_TOP_LEFT : (dField.hovered_sequence == 1) ? LINK_MARKER_TOP : LINK_MARKER_TOP_RIGHT;
          }
          CheckMutual(pcard2, arrow);
          driver->drawVertexPrimitiveList(&matManager.vFieldMzone[dField.hovered_controler][5], 4, matManager.iRectangle, 2);
        }
        if ((mark & LINK_MARKER_TOP_LEFT && dField.hovered_sequence == 4) || (mark & LINK_MARKER_TOP && dField.hovered_sequence == 3) || (mark & LINK_MARKER_TOP_RIGHT && dField.hovered_sequence == 2)) {
          int arrow = (dField.hovered_sequence == 4) ? LINK_MARKER_BOTTOM_RIGHT : (dField.hovered_sequence == 3) ? LINK_MARKER_BOTTOM : LINK_MARKER_BOTTOM_LEFT;
          pcard2 = dField.mzone[dField.hovered_controler][6];
          if (!pcard2) {
            pcard2 = dField.mzone[1 - dField.hovered_controler][5];
            arrow = (dField.hovered_sequence == 4) ? LINK_MARKER_TOP_LEFT : (dField.hovered_sequence == 3) ? LINK_MARKER_TOP : LINK_MARKER_TOP_RIGHT;
          }
          CheckMutual(pcard2, arrow);
          driver->drawVertexPrimitiveList(&matManager.vFieldMzone[dField.hovered_controler][6], 4, matManager.iRectangle, 2);
        }
      }
    }
    else {
      int swap = (dField.hovered_sequence == 5) ? 0 : 2;
      if (mark & LINK_MARKER_BOTTOM_LEFT) {
        pcard2 = dField.mzone[dField.hovered_controler][0 + swap];
        CheckMutual(pcard2, LINK_MARKER_TOP_RIGHT);
        driver->drawVertexPrimitiveList(&matManager.vFieldMzone[dField.hovered_controler][0 + swap], 4, matManager.iRectangle, 2);
      }
      if (mark & LINK_MARKER_BOTTOM) {
        pcard2 = dField.mzone[dField.hovered_controler][1 + swap];
        CheckMutual(pcard2, LINK_MARKER_TOP);
        driver->drawVertexPrimitiveList(&matManager.vFieldMzone[dField.hovered_controler][1 + swap], 4, matManager.iRectangle, 2);
      }
      if (mark & LINK_MARKER_BOTTOM_RIGHT) {
        pcard2 = dField.mzone[dField.hovered_controler][2 + swap];
        CheckMutual(pcard2, LINK_MARKER_TOP_LEFT);
        driver->drawVertexPrimitiveList(&matManager.vFieldMzone[dField.hovered_controler][2 + swap], 4, matManager.iRectangle, 2);
      }
      if (mark & LINK_MARKER_TOP_LEFT) {
        pcard2 = dField.mzone[1 - dField.hovered_controler][4 - swap];
        CheckMutual(pcard2, LINK_MARKER_TOP_LEFT);
        driver->drawVertexPrimitiveList(&matManager.vFieldMzone[1 - dField.hovered_controler][4 - swap], 4, matManager.iRectangle, 2);
      }
      if (mark & LINK_MARKER_TOP) {
        pcard2 = dField.mzone[1 - dField.hovered_controler][3 - swap];
        CheckMutual(pcard2, LINK_MARKER_TOP);
        driver->drawVertexPrimitiveList(&matManager.vFieldMzone[1 - dField.hovered_controler][3 - swap], 4, matManager.iRectangle, 2);
      }
      if (mark & LINK_MARKER_TOP_RIGHT) {
        pcard2 = dField.mzone[1 - dField.hovered_controler][2 - swap];
        CheckMutual(pcard2, LINK_MARKER_TOP_RIGHT);
        driver->drawVertexPrimitiveList(&matManager.vFieldMzone[1 - dField.hovered_controler][2 - swap], 4, matManager.iRectangle, 2);
      }
    }
  }

  void Game::CheckMutual(ClientCard *pcard, int mark) {
    matManager.mSelField.AmbientColor = 0xff0261a2;
    driver->setMaterial(matManager.mSelField);
    if (pcard && pcard->type & TYPE_LINK && pcard->link_marker & mark) {
      matManager.mSelField.AmbientColor = 0xff009900;
      driver->setMaterial(matManager.mSelField);
    }
  }

  void Game::DrawCards() {
    for (auto cit = dField.overlay_cards.begin(); cit != dField.overlay_cards.end(); ++cit) {
      auto *pcard = (*cit);
      auto *olcard = pcard->overlayTarget;
      if (pcard->aniFrame) {
        DrawCard(pcard);
      }
      else if (olcard && olcard->location == LOCATION_MZONE) {
        if (pcard->sequence < MAX_LAYER_COUNT) {
          DrawCard(pcard);
        }
      }
      else {
        DrawCard(pcard);
      }
    }
    for (int p = 0; p < 2; ++p) {
      for (auto &i : dField.szone[p]) {
        if (i) {
          DrawCard(i);
        }
      }
      for (auto &i : dField.mzone[p]) {
        if (i) {
          DrawCard(i);
        }
      }
      for (auto &i : dField.deck[p]) {
        DrawCard(i);
      }
      for (auto &i : dField.hand[p]) {
        DrawCard(i);
      }
      for (auto &i : dField.grave[p]) {
        DrawCard(i);
      }
      for (auto &i : dField.remove[p]) {
        DrawCard(i);
      }
      for (auto &i : dField.extra[p]) {
        DrawCard(i);
      }
    }
  }

  void Game::DrawCard(ClientCard *pcard) {
    if (pcard->aniFrame) {
      if (pcard->is_moving) {
        pcard->curPos += pcard->dPos;
        pcard->curRot += pcard->dRot;
        pcard->mTransform.setTranslation(pcard->curPos);
        pcard->mTransform.setRotationRadians(pcard->curRot);
      }
      if (pcard->is_fading) {
        pcard->curAlpha += pcard->dAlpha;
      }
      pcard->aniFrame--;
      if (pcard->aniFrame == 0) {
        pcard->is_moving = false;
        pcard->is_fading = false;
      }
    }
    matManager.mCard.AmbientColor = 0xffffffff;
    matManager.mCard.DiffuseColor = (pcard->curAlpha << 24) | 0xffffff;
    driver->setTransform(irr::video::ETS_WORLD, pcard->mTransform);
    auto m22 = pcard->mTransform(2, 2);
    if (m22 > -0.99 || pcard->is_moving) {
      matManager.mCard.setTexture(0, imageManager.GetTexture(pcard->code));
      driver->setMaterial(matManager.mCard);
      driver->drawVertexPrimitiveList(matManager.vCardFront, 4, matManager.iRectangle, 2);
    }
    if (m22 < 0.99 || pcard->is_moving) {
      matManager.mCard.setTexture(0, imageManager.tCover[pcard->controler]);
      driver->setMaterial(matManager.mCard);
      driver->drawVertexPrimitiveList(matManager.vCardBack, 4, matManager.iRectangle, 2);
    }
    if (pcard->is_moving) {
      return;
    }
    if (pcard->is_selectable && (pcard->location & 0xe)) {
      float cv[4] = {1.0f, 1.0f, 0.0f, 1.0f};
      if ((pcard->location == LOCATION_HAND && pcard->code) || ((pcard->location & LOCATION_ONFIELD) && (pcard->position & POS_FACEUP))) {
        DrawSelectionLine(matManager.vCardOutline, !pcard->is_selected, 2, cv);
      }
      else {
        DrawSelectionLine(matManager.vCardOutliner, !pcard->is_selected, 2, cv);
      }
    }
    if (pcard->is_highlighting) {
      float cv[4] = {0.0f, 1.0f, 1.0f, 1.0f};
      if ((pcard->location == LOCATION_HAND && pcard->code) || ((pcard->location & LOCATION_ONFIELD) && (pcard->position & POS_FACEUP))) {
        DrawSelectionLine(matManager.vCardOutline, true, 2, cv);
      }
      else {
        DrawSelectionLine(matManager.vCardOutliner, true, 2, cv);
      }
    }
    irr::core::matrix4 im;
    im.setTranslation(pcard->curPos);
    driver->setTransform(irr::video::ETS_WORLD, im);
    if (pcard->is_showequip) {
      matManager.mTexture.setTexture(0, imageManager.tEquip);
      driver->setMaterial(matManager.mTexture);
      driver->drawVertexPrimitiveList(matManager.vSymbol, 4, matManager.iRectangle, 2);
    }
    else if (pcard->is_showtarget) {
      matManager.mTexture.setTexture(0, imageManager.tTarget);
      driver->setMaterial(matManager.mTexture);
      driver->drawVertexPrimitiveList(matManager.vSymbol, 4, matManager.iRectangle, 2);
    }
    else if (pcard->is_showchaintarget) {
      matManager.mTexture.setTexture(0, imageManager.tChainTarget);
      driver->setMaterial(matManager.mTexture);
      driver->drawVertexPrimitiveList(matManager.vSymbol, 4, matManager.iRectangle, 2);
    }
    else if ((pcard->status & (STATUS_DISABLED | STATUS_FORBIDDEN)) && (pcard->location & LOCATION_ONFIELD) && (pcard->position & POS_FACEUP)) {
      matManager.mTexture.setTexture(0, imageManager.tNegated);
      driver->setMaterial(matManager.mTexture);
      driver->drawVertexPrimitiveList(matManager.vNegate, 4, matManager.iRectangle, 2);
    }
    if (pcard->cmdFlag & COMMAND_ATTACK) {
      matManager.mTexture.setTexture(0, imageManager.tAttack);
      driver->setMaterial(matManager.mTexture);
      irr::core::matrix4 atk;
      atk.setTranslation(pcard->curPos + irr::core::vector3df(0, (pcard->controler == 0 ? -1 : 1) * (atkdy / 4.0f + 0.35f), 0.05f));
      atk.setRotationRadians(irr::core::vector3df(0, 0, pcard->controler == 0 ? 0 : 3.1415926f));
      driver->setTransform(irr::video::ETS_WORLD, atk);
      driver->drawVertexPrimitiveList(matManager.vSymbol, 4, matManager.iRectangle, 2);
    }
  }

  template <typename T> void Game::DrawShadowText(irr::gui::CGUITTFont *font, const T &text, const irr::core::rect<irr::s32> &position, const irr::core::rect<irr::s32> &padding, irr::video::SColor color, irr::video::SColor shadowcolor, bool hcenter, bool vcenter, const irr::core::rect<irr::s32> *clip) {
    irr::core::rect<irr::s32> shadowposition = irr::core::recti(position.UpperLeftCorner.X - padding.UpperLeftCorner.X, position.UpperLeftCorner.Y - padding.UpperLeftCorner.Y, position.LowerRightCorner.X - padding.LowerRightCorner.X, position.LowerRightCorner.Y - padding.LowerRightCorner.Y);
    font->draw(text, shadowposition, shadowcolor, hcenter, vcenter, clip);
    font->draw(text, position, color, hcenter, vcenter, clip);
  }

  void Game::DrawMisc() {
    static irr::core::vector3df act_rot(0, 0, 0);
    int rule = (dInfo.duel_rule >= 4) ? 1 : 0;
    irr::core::matrix4 im;
    irr::core::matrix4 ic;
    irr::core::matrix4 it;
    irr::core::matrix4 ig;
    act_rot.Z += 0.02f;
    im.setRotationRadians(act_rot);
    matManager.mTexture.setTexture(0, imageManager.tAct);
    driver->setMaterial(matManager.mTexture);
    for (int player = 0; player < 2; ++player) {
      if (dField.deck_act[player]) {
        im.setTranslation(irr::core::vector3df((matManager.vFieldDeck[player][0].Pos.X + matManager.vFieldDeck[player][1].Pos.X) / 2, (matManager.vFieldDeck[player][0].Pos.Y + matManager.vFieldDeck[player][2].Pos.Y) / 2, dField.deck[player].size() * 0.01f + 0.02f));
        driver->setTransform(irr::video::ETS_WORLD, im);
        driver->drawVertexPrimitiveList(matManager.vActivate, 4, matManager.iRectangle, 2);
      }
      if (dField.grave_act[player]) {
        im.setTranslation(irr::core::vector3df((matManager.vFieldGrave[player][rule][0].Pos.X + matManager.vFieldGrave[player][rule][1].Pos.X) / 2, (matManager.vFieldGrave[player][rule][0].Pos.Y + matManager.vFieldGrave[player][rule][2].Pos.Y) / 2, dField.grave[player].size() * 0.01f + 0.02f));
        driver->setTransform(irr::video::ETS_WORLD, im);
        driver->drawVertexPrimitiveList(matManager.vActivate, 4, matManager.iRectangle, 2);
      }
      if (dField.remove_act[player]) {
        im.setTranslation(irr::core::vector3df((matManager.vFieldRemove[player][rule][0].Pos.X + matManager.vFieldRemove[player][rule][1].Pos.X) / 2, (matManager.vFieldRemove[player][rule][0].Pos.Y + matManager.vFieldRemove[player][rule][2].Pos.Y) / 2, dField.remove[player].size() * 0.01f + 0.02f));
        driver->setTransform(irr::video::ETS_WORLD, im);
        driver->drawVertexPrimitiveList(matManager.vActivate, 4, matManager.iRectangle, 2);
      }
      if (dField.extra_act[player]) {
        im.setTranslation(irr::core::vector3df((matManager.vFieldExtra[player][0].Pos.X + matManager.vFieldExtra[player][1].Pos.X) / 2, (matManager.vFieldExtra[player][0].Pos.Y + matManager.vFieldExtra[player][2].Pos.Y) / 2, dField.extra[player].size() * 0.01f + 0.02f));
        driver->setTransform(irr::video::ETS_WORLD, im);
        driver->drawVertexPrimitiveList(matManager.vActivate, 4, matManager.iRectangle, 2);
      }
      if (dField.pzone_act[player]) {
        int seq = dInfo.duel_rule >= 4 ? 0 : 6;
        im.setTranslation(irr::core::vector3df((matManager.vFieldSzone[player][seq][rule][0].Pos.X + matManager.vFieldSzone[player][seq][rule][1].Pos.X) / 2, (matManager.vFieldSzone[player][seq][rule][0].Pos.Y + matManager.vFieldSzone[player][seq][rule][2].Pos.Y) / 2, 0.03f));
        driver->setTransform(irr::video::ETS_WORLD, im);
        driver->drawVertexPrimitiveList(matManager.vActivate, 4, matManager.iRectangle, 2);
      }
    }
    if (dField.conti_act) {
      irr::core::vector3df pos = irr::core::vector3df((matManager.vFieldContiAct[0].X + matManager.vFieldContiAct[1].X) / 2, (matManager.vFieldContiAct[0].Y + matManager.vFieldContiAct[2].Y) / 2, 0);
      im.setRotationRadians(irr::core::vector3df(0, 0, 0));
      for (auto cit = dField.conti_cards.begin(); cit != dField.conti_cards.end(); ++cit) {
        im.setTranslation(pos);
        driver->setTransform(irr::video::ETS_WORLD, im);
        matManager.mCard.setTexture(0, imageManager.GetTexture((*cit)->code));
        driver->setMaterial(matManager.mCard);
        driver->drawVertexPrimitiveList(matManager.vCardFront, 4, matManager.iRectangle, 2);
        pos.Z += 0.03f;
      }
      im.setTranslation(pos);
      im.setRotationRadians(act_rot);
      driver->setTransform(irr::video::ETS_WORLD, im);
      driver->setMaterial(matManager.mTexture);
      driver->drawVertexPrimitiveList(matManager.vActivate, 4, matManager.iRectangle, 2);
    }
    if (dField.chains.size() > 1 || mainGame->gameConf.draw_single_chain) {
      for (size_t i = 0; i < dField.chains.size(); ++i) {
        if (dField.chains[i].solved) {
          break;
        }
        matManager.mTRTexture.setTexture(0, imageManager.tChain);
        matManager.mTRTexture.AmbientColor = 0xffffff00;
        ic.setRotationRadians(act_rot);
        ic.setTranslation(dField.chains[i].chain_pos);
        driver->setMaterial(matManager.mTRTexture);
        driver->setTransform(irr::video::ETS_WORLD, ic);
        driver->drawVertexPrimitiveList(matManager.vSymbol, 4, matManager.iRectangle, 2);
        it.setScale(0.6f);
        it.setTranslation(dField.chains[i].chain_pos);
        matManager.mTRTexture.setTexture(0, imageManager.tNumber);
        matManager.vChainNum[0].TCoords = irr::core::vector2df(0.19375f * (i % 5), 0.2421875f * (i / 5));
        matManager.vChainNum[1].TCoords = irr::core::vector2df(0.19375f * (i % 5 + 1), 0.2421875f * (i / 5));
        matManager.vChainNum[2].TCoords = irr::core::vector2df(0.19375f * (i % 5), 0.2421875f * (i / 5 + 1));
        matManager.vChainNum[3].TCoords = irr::core::vector2df(0.19375f * (i % 5 + 1), 0.2421875f * (i / 5 + 1));
        driver->setMaterial(matManager.mTRTexture);
        driver->setTransform(irr::video::ETS_WORLD, it);
        driver->drawVertexPrimitiveList(matManager.vChainNum, 4, matManager.iRectangle, 2);
      }
    }
    if (dField.cant_check_grave) {
      matManager.mTexture.setTexture(0, imageManager.tNegated);
      driver->setMaterial(matManager.mTexture);
      ig.setTranslation(irr::core::vector3df((matManager.vFieldGrave[0][rule][0].Pos.X + matManager.vFieldGrave[0][rule][1].Pos.X) / 2, (matManager.vFieldGrave[0][rule][0].Pos.Y + matManager.vFieldGrave[0][rule][2].Pos.Y) / 2, dField.grave[0].size() * 0.01f + 0.02f));
      driver->setTransform(irr::video::ETS_WORLD, ig);
      driver->drawVertexPrimitiveList(matManager.vNegate, 4, matManager.iRectangle, 2);
      ig.setTranslation(irr::core::vector3df((matManager.vFieldGrave[1][rule][0].Pos.X + matManager.vFieldGrave[1][rule][1].Pos.X) / 2, (matManager.vFieldGrave[1][rule][0].Pos.Y + matManager.vFieldGrave[1][rule][2].Pos.Y) / 2, dField.grave[1].size() * 0.01f + 0.02f));
      driver->setTransform(irr::video::ETS_WORLD, ig);
      driver->drawVertexPrimitiveList(matManager.vNegate, 4, matManager.iRectangle, 2);
    }
    // finish button
    //~ if (btnCancelOrFinish->isVisible() && dField.select_ready) {
    //~ DrawSelectionLine(btnCancelOrFinish, 2, 0xffffff00);
    //~ }
    //~ if (btnLeaveGame->isVisible() && dField.tag_teammate_surrender) {
    //~ DrawSelectionLine(btnLeaveGame, 2, 0xffffff00);
    //~ }
    // lp bar
    if ((dInfo.turn % 2 && dInfo.isFirst) || (!(dInfo.turn % 2) && !dInfo.isFirst)) {
      driver->draw2DRectangle(0xa0000000, Resize(327, 8, 630, 51));
      driver->draw2DRectangleOutline(Resize(327, 8, 630, 51), 0xffff8080);
    }
    else {
      driver->draw2DRectangle(0xa0000000, Resize(689, 8, 991, 51));
      driver->draw2DRectangleOutline(Resize(689, 8, 991, 51), 0xffff8080);
    }
    driver->draw2DImage(imageManager.tLPFrame, Resize(330, 10, 629, 30), irr::core::recti(0, 0, 200, 20), nullptr, nullptr, true);
    driver->draw2DImage(imageManager.tLPFrame, Resize(691, 10, 990, 30), irr::core::recti(0, 0, 200, 20), nullptr, nullptr, true);
    if (dInfo.start_lp) {
      auto maxLP = dInfo.isTag ? dInfo.start_lp / 2 : dInfo.start_lp;
      if (dInfo.lp[0] >= maxLP) {
        auto layerCount = dInfo.lp[0] / maxLP;
        auto partialLP = dInfo.lp[0] % maxLP;
        auto bgColorPos = (layerCount - 1) % 5;
        auto fgColorPos = layerCount % 5;
        driver->draw2DImage(imageManager.tLPBar, Resize(335 + 290 * partialLP / maxLP, 12, 625, 28), irr::core::recti(0, bgColorPos * 16, 16, (bgColorPos + 1) * 16), nullptr, nullptr, true);
        if (partialLP > 0) {
          driver->draw2DImage(imageManager.tLPBar, Resize(335, 12, 335 + 290 * partialLP / maxLP, 28), irr::core::recti(0, fgColorPos * 16, 16, (fgColorPos + 1) * 16), nullptr, nullptr, true);
        }
      }
      else {
        driver->draw2DImage(imageManager.tLPBar, Resize(335, 12, 335 + 290 * dInfo.lp[0] / maxLP, 28), irr::core::recti(0, 0, 16, 16), nullptr, nullptr, true);
      }
      if (dInfo.lp[1] >= maxLP) {
        auto layerCount = dInfo.lp[1] / maxLP;
        auto partialLP = dInfo.lp[1] % maxLP;
        auto bgColorPos = (layerCount - 1) % 5;
        auto fgColorPos = layerCount % 5;
        driver->draw2DImage(imageManager.tLPBar, Resize(696, 12, 986 - 290 * partialLP / maxLP, 28), irr::core::recti(0, bgColorPos * 16, 16, (bgColorPos + 1) * 16), nullptr, nullptr, true);
        if (partialLP > 0) {
          driver->draw2DImage(imageManager.tLPBar, Resize(986 - 290 * partialLP / maxLP, 12, 986, 28), irr::core::recti(0, fgColorPos * 16, 16, (fgColorPos + 1) * 16), nullptr, nullptr, true);
        }
      }
      else {
        driver->draw2DImage(imageManager.tLPBar, Resize(986 - 290 * dInfo.lp[1] / maxLP, 12, 986, 28), irr::core::recti(0, 0, 16, 16), nullptr, nullptr, true);
      }
    }
    if (lpframe) {
      dInfo.lp[lpplayer] -= lpd;
      myswprintf(dInfo.strLP[lpplayer], L"%d", dInfo.lp[lpplayer]);
      lpccolor -= 0x19000000;
      lpframe--;
    }
    if (!lpcstring.empty()) {
      if (lpplayer == 0) {
        DrawShadowText(lpcFont, lpcstring, Resize(400, 472, 922, 520), Resize(0, 2, 2, 0), lpccolor, lpccolor | 0x00ffffff, true, false, nullptr);
      }
      else {
        DrawShadowText(lpcFont, lpcstring, Resize(400, 162, 922, 210), Resize(0, 2, 2, 0), lpccolor, lpccolor | 0x00ffffff, true, false, nullptr);
      }
    }
    if (!dInfo.isReplay && dInfo.player_type < 7 && dInfo.time_limit) {
      driver->draw2DRectangle(Resize(525, 34, 525 + dInfo.time_left[0] * 100 / dInfo.time_limit, 44), 0xa0e0e0e0, 0xa0e0e0e0, 0xa0c0c0c0, 0xa0c0c0c0);
      driver->draw2DRectangleOutline(Resize(525, 34, 625, 44), 0xffffffff);
      driver->draw2DRectangle(Resize(795 - dInfo.time_left[1] * 100 / dInfo.time_limit, 34, 795, 44), 0xa0e0e0e0, 0xa0e0e0e0, 0xa0c0c0c0, 0xa0c0c0c0);
      driver->draw2DRectangleOutline(Resize(695, 34, 795, 44), 0xffffffff);
    }
    DrawShadowText(numFont, dInfo.strLP[0], Resize(330, 12, 631, 30), Resize(0, 1, 2, 0), 0xffffff00, 0xff000000, true, false, nullptr);
    DrawShadowText(numFont, dInfo.strLP[1], Resize(691, 12, 992, 30), Resize(0, 1, 2, 0), 0xffffff00, 0xff000000, true, false, nullptr);

    if (!gameConf.hide_player_name) {
      irr::core::recti p1size = Resize(335, 31, 629, 50);
      irr::core::recti p2size = Resize(986, 31, 986, 50);
      if (!dInfo.isTag || !dInfo.tag_player[0]) {
        textFont->draw(dInfo.hostname, p1size, 0xffffffff, false, false, nullptr);
      }
      else {
        textFont->draw(dInfo.hostname_tag, p1size, 0xffffffff, false, false, nullptr);
      }
      if (!dInfo.isTag || !dInfo.tag_player[1]) {
        auto cld = textFont->getDimension(dInfo.clientname);
        p2size.UpperLeftCorner.X -= cld.Width;
        textFont->draw(dInfo.clientname, p2size, 0xffffffff, false, false, nullptr);
      }
      else {
        auto cld = textFont->getDimension(dInfo.clientname_tag);
        p2size.UpperLeftCorner.X -= cld.Width;
        textFont->draw(dInfo.clientname_tag, p2size, 0xffffffff, false, false, nullptr);
      }
    }
    driver->draw2DRectangle(Resize(632, 10, 688, 30), 0x00000000, 0x00000000, 0xffffffff, 0xffffffff);
    driver->draw2DRectangle(Resize(632, 30, 688, 50), 0xffffffff, 0xffffffff, 0x00000000, 0x00000000);
    DrawShadowText(lpcFont, dataManager.GetNumString(dInfo.turn).c_str(), Resize(635, 5, 687, 40), Resize(0, 0, 2, 0), 0x8000ffff, 0x80000000, true, false, nullptr);
    ClientCard *pcard = nullptr;
    for (int i = 0; i < 5; ++i) {
      pcard = dField.mzone[0][i];
      if (pcard && pcard->code != 0) {
        DrawStatus(pcard, 493 + i * 85, 416, 473 + i * 80, 356);
      }
    }
    pcard = dField.mzone[0][5];
    if (pcard && pcard->code != 0) {
      DrawStatus(pcard, 589, 338, 563, 291);
    }
    pcard = dField.mzone[0][6];
    if (pcard && pcard->code != 0) {
      DrawStatus(pcard, 743, 338, 712, 291);
    }
    for (int i = 0; i < 5; ++i) {
      pcard = dField.mzone[1][i];
      if (pcard && (pcard->position & POS_FACEUP)) {
        DrawStatus(pcard, 803 - i * 68, 235, 779 - i * 71, 272);
      }
    }
    pcard = dField.mzone[1][5];
    if (pcard && (pcard->position & POS_FACEUP)) {
      DrawStatus(pcard, 739, 291, 710, 338);
    }
    pcard = dField.mzone[1][6];
    if (pcard && (pcard->position & POS_FACEUP)) {
      DrawStatus(pcard, 593, 291, 555, 338);
    }
    if (dInfo.duel_rule < 4) {
      pcard = dField.szone[0][6];
      if (pcard) {
        adFont->draw(pcard->lscstring, ResizeWin(427, 395, 439, 415), 0xffffffff);
      }
      pcard = dField.szone[0][7];
      if (pcard) {
        adFont->draw(pcard->rscstring, ResizeWin(881, 395, 913, 415), 0xffffffff);
      }
      pcard = dField.szone[1][6];
      if (pcard) {
        adFont->draw(pcard->lscstring, ResizeWin(840, 246, 872, 266), 0xffffffff);
      }
      pcard = dField.szone[1][7];
      if (pcard) {
        adFont->draw(pcard->rscstring, ResizeWin(464, 246, 496, 266), 0xffffffff);
      }
    }
    else {
      pcard = dField.szone[0][0];
      if (pcard && (pcard->type & TYPE_PENDULUM) && !pcard->equipTarget) {
        adFont->draw(pcard->lscstring, ResizeWin(455, 431, 467, 451), 0xffffffff);
      }
      pcard = dField.szone[0][4];
      if (pcard && (pcard->type & TYPE_PENDULUM) && !pcard->equipTarget) {
        adFont->draw(pcard->rscstring, ResizeWin(851, 431, 883, 451), 0xffffffff);
      }
      pcard = dField.szone[1][0];
      if (pcard && (pcard->type & TYPE_PENDULUM) && !pcard->equipTarget) {
        adFont->draw(pcard->lscstring, ResizeWin(807, 223, 839, 243), 0xffffffff);
      }
      pcard = dField.szone[1][4];
      if (pcard && (pcard->type & TYPE_PENDULUM) && !pcard->equipTarget) {
        adFont->draw(pcard->rscstring, ResizeWin(499, 223, 531, 243), 0xffffffff);
      }
    }
    if (!dField.extra[0].empty()) {
      int offset = (dField.extra[0].size() >= 10) ? 0 : numFont->getDimension(dataManager.GetNumString(1).c_str()).Width;
      DrawShadowText(numFont, dataManager.GetNumString(dField.extra[0].size()).c_str(), Resize(320, 563, 373, 553, offset, 0, 0, 0), Resize(0, 1, 2, 1), 0xffffff00, 0xff000000, true, false, nullptr);
      DrawShadowText(numFont, dataManager.GetNumString(dField.extra_p_count[0], true).c_str(), Resize(340, 563, 393, 553), Resize(0, 1, 2, 1), 0xffffff00, 0xff000000, true, false, nullptr);
    }
    if (!dField.deck[0].empty()) {
      DrawShadowText(numFont, dataManager.GetNumString(dField.deck[0].size()).c_str(), Resize(908, 563, 1023, 553), Resize(0, 1, 2, 1), 0xffffff00, 0xff000000, true, false, nullptr);
    }
    if (rule == 0) {
      if (!dField.grave[0].empty()) {
        DrawShadowText(numFont, dataManager.GetNumString(dField.grave[0].size()).c_str(), Resize(837, 376, 986, 381), Resize(0, 1, 2, 1), 0xffffff00, 0xff000000, true, false, nullptr);
      }
      if (!dField.remove[0].empty()) {
        DrawShadowText(numFont, dataManager.GetNumString(dField.remove[0].size()).c_str(), Resize(1015, 376, 959, 381), Resize(0, 1, 2, 1), 0xffffff00, 0xff000000, true, false, nullptr);
      }
    }
    else {
      if (!dField.grave[0].empty()) {
        DrawShadowText(numFont, dataManager.GetNumString(dField.grave[0].size()).c_str(), Resize(870, 457, 1004, 462), Resize(0, 1, 2, 1), 0xffffff00, 0xff000000, true, false, nullptr);
      }
      if (!dField.remove[0].empty()) {
        DrawShadowText(numFont, dataManager.GetNumString(dField.remove[0].size()).c_str(), Resize(837, 376, 986, 381), Resize(0, 1, 2, 1), 0xffffff00, 0xff000000, true, false, nullptr);
      }
    }
    if (!dField.extra[1].empty()) {
      int offset = (dField.extra[1].size() >= 10) ? 0 : numFont->getDimension(dataManager.GetNumString(1).c_str()).Width;
      DrawShadowText(numFont, dataManager.GetNumString(dField.extra[1].size()).c_str(), Resize(808, 208, 900, 233, offset, 0, 0, 0), Resize(0, 1, 2, 1), 0xffffff00, 0xff000000, true, false, nullptr);
      DrawShadowText(numFont, dataManager.GetNumString(dField.extra_p_count[1], true).c_str(), Resize(828, 208, 920, 233), Resize(0, 1, 2, 1), 0xffffff00, 0xff000000, true, false, nullptr);
    }
    if (!dField.deck[1].empty()) {
      DrawShadowText(numFont, dataManager.GetNumString(dField.deck[1].size()).c_str(), Resize(465, 208, 483, 233), Resize(0, 1, 2, 1), 0xffffff00, 0xff000000, true, false, nullptr);
    }
    if (rule == 0) {
      if (!dField.grave[1].empty()) {
        DrawShadowText(numFont, dataManager.GetNumString(dField.grave[1].size()).c_str(), Resize(420, 311, 464, 282), Resize(0, 1, 2, 1), 0xffffff00, 0xff000000, true, false, nullptr);
      }
      if (!dField.remove[1].empty()) {
        DrawShadowText(numFont, dataManager.GetNumString(dField.remove[1].size()).c_str(), Resize(300, 311, 445, 341), Resize(0, 1, 2, 1), 0xffffff00, 0xff000000, true, false, nullptr);
      }
    }
    else {
      if (!dField.grave[1].empty()) {
        DrawShadowText(numFont, dataManager.GetNumString(dField.grave[1].size()).c_str(), Resize(455, 250, 464, 300), Resize(0, 1, 2, 1), 0xffffff00, 0xff000000, true, false, nullptr);
      }
      if (!dField.remove[1].empty()) {
        DrawShadowText(numFont, dataManager.GetNumString(dField.remove[1].size()).c_str(), Resize(420, 311, 464, 282), Resize(0, 1, 2, 1), 0xffffff00, 0xff000000, true, false, nullptr);
      }
    }
  }

  void Game::DrawStatus(ClientCard *pcard, int x1, int y1, int x2, int y2) {
    auto rect = ResizeWin(x1, y1 + 1, x1, y1 + 21);
    int slash_w = adFont->getDimension(L"/").Width;
    rect.UpperLeftCorner.X -= slash_w;
    adFont->draw(L"/", rect, 0xffffffff);
    int atk_w = adFont->getDimension(pcard->atkstring).Width;
    rect.UpperLeftCorner.X -= atk_w;
    adFont->draw(pcard->atkstring, rect, pcard->attack > pcard->base_attack ? 0xffffff00 : pcard->attack < pcard->base_attack ? 0xffff2090 : 0xffffffff);
    rect.UpperLeftCorner.X += slash_w;
    rect.UpperLeftCorner.X += atk_w;
    if (pcard->type & TYPE_LINK) {
      int64_t link_w = adFont->getDimension(pcard->linkstring).Width;
      rect.LowerRightCorner.X += link_w;
      adFont->draw(pcard->linkstring, rect, 0xff99ffff);
    }
    else {
      int64_t def_w = adFont->getDimension(pcard->defstring).Width;
      rect.LowerRightCorner.X += def_w;
      adFont->draw(pcard->defstring, rect, pcard->defense > pcard->base_defense ? 0xffffff00 : pcard->defense < pcard->base_defense ? 0xffff2090 : 0xffffffff);
      adFont->draw(pcard->lvstring, ResizeWin(x2 + 1, y2, x2 + 3, y2 + 21), (pcard->type & TYPE_XYZ) ? 0xffff80ff : (pcard->type & TYPE_TUNER) ? 0xffffff00 : 0xffffffff);
    }
  }

  void Game::DrawGUI() {
    while (!imageLoading.empty()) {
      auto mit = imageLoading.cbegin();
      mit->first->setImage(imageManager.GetTexture(mit->second));
      imageLoading.erase(mit);
    }
    guiEnv->drawAll();
    if (focus_element) {
      guiEnv->setFocus(focus_element);
      focus_element = nullptr;
    }
  }

  void Game::DrawSpec() {
    irr::s32 midx = 574 + (CARD_IMG_WIDTH * 0.5);
    irr::s32 midy = 150 + (CARD_IMG_HEIGHT * 0.5);
    if (showcard) {
      switch (showcard) {
        case 1: {
          driver->draw2DImage(imageManager.GetTexture(showcardcode, true), ResizeCardHint(574, 150));
          //~ showcardcode
          //~ fast_io::io::print(fast_io::win32_box_t(), __FILE__, "\n", __LINE__, "\n", __PRETTY_FUNCTION__);
          driver->draw2DImage(imageManager.tMask, ResizeCardMid(574, 150, 574 + (showcarddif > CARD_IMG_WIDTH ? CARD_IMG_WIDTH : showcarddif), 150 + CARD_IMG_HEIGHT, midx, midy), irr::core::recti(CARD_IMG_HEIGHT - showcarddif, 0, CARD_IMG_HEIGHT - (showcarddif > CARD_IMG_WIDTH ? showcarddif - CARD_IMG_WIDTH : 0), CARD_IMG_HEIGHT), nullptr, nullptr, true);
          showcarddif += 15;
          if (showcarddif >= CARD_IMG_HEIGHT) {
            showcard = 2;
            showcarddif = 0;
          }
          break;
        }
        case 2: {
          driver->draw2DImage(imageManager.GetTexture(showcardcode, true), ResizeCardHint(574, 150));
          driver->draw2DImage(imageManager.tMask, ResizeCardMid(574 + showcarddif, 150, 574 + CARD_IMG_WIDTH, 150 + CARD_IMG_HEIGHT, midx, midy), irr::core::recti(0, 0, CARD_IMG_WIDTH - showcarddif, CARD_IMG_HEIGHT), nullptr, nullptr, true);
          showcarddif += 15;
          if (showcarddif >= CARD_IMG_WIDTH) {
            showcard = 0;
          }
          break;
        }
        case 3: {
          driver->draw2DImage(imageManager.GetTexture(showcardcode, true), ResizeCardHint(574, 150));
          driver->draw2DImage(imageManager.tNegated, ResizeCardMid(536 + showcarddif, 141 + showcarddif, 792 - showcarddif, 397 - showcarddif, midx, midy), irr::core::recti(0, 0, 128, 128), nullptr, nullptr, true);
          if (showcarddif < 64) {
            showcarddif += 4;
          }
          break;
        }
        case 4: {
          matManager.c2d[0] = (showcarddif << 24) | 0xffffff;
          matManager.c2d[1] = (showcarddif << 24) | 0xffffff;
          matManager.c2d[2] = (showcarddif << 24) | 0xffffff;
          matManager.c2d[3] = (showcarddif << 24) | 0xffffff;
          driver->draw2DImage(imageManager.GetTexture(showcardcode, true), ResizeCardHint(574, 150, 574 + CARD_IMG_WIDTH, 150 + CARD_IMG_HEIGHT), ResizeFit(0, 0, CARD_IMG_WIDTH, CARD_IMG_HEIGHT), nullptr, matManager.c2d, true);
          if (showcarddif < 255) {
            showcarddif += 17;
          }
          break;
        }
        case 5: {
          matManager.c2d[0] = (showcarddif << 25) | 0xffffff;
          matManager.c2d[1] = (showcarddif << 25) | 0xffffff;
          matManager.c2d[2] = (showcarddif << 25) | 0xffffff;
          matManager.c2d[3] = (showcarddif << 25) | 0xffffff;
          driver->draw2DImage(imageManager.GetTexture(showcardcode, true), ResizeCardMid(662 - showcarddif * 0.69685f, 277 - showcarddif, 662 + showcarddif * 0.69685f, 277 + showcarddif, midx, midy), ResizeFit(0, 0, CARD_IMG_WIDTH, CARD_IMG_HEIGHT), nullptr, matManager.c2d, true);
          if (showcarddif < 127) {
            showcarddif += 9;
          }
          break;
        }
        case 6: {
          driver->draw2DImage(imageManager.GetTexture(showcardcode, true), ResizeCardHint(574, 150));
          driver->draw2DImage(imageManager.tNumber, ResizeCardMid(536 + showcarddif, 141 + showcarddif, 792 - showcarddif, 397 - showcarddif, midx, midy), irr::core::recti((showcardp % 5) * 64, (showcardp / 5) * 64, (showcardp % 5 + 1) * 64, (showcardp / 5 + 1) * 64), nullptr, nullptr, true);
          if (showcarddif < 64) {
            showcarddif += 4;
          }
          break;
        }
        case 7: {
          float mul = xScale;
          if (xScale > yScale) {
            mul = yScale;
          }
          irr::core::vector2d<irr::s32> corner[4];
          float y = sin(showcarddif * 3.1415926f / 180.0f) * CARD_IMG_HEIGHT * mul;
          irr::s32 winx = midx * xScale + (574 - midx) * mul;
          irr::s32 winx2 = midx * xScale + (751 - midx) * mul;
          irr::s32 winy = midy * yScale + (404 - midy) * mul;
          corner[0] = irr::core::vector2d<irr::s32>(winx - (CARD_IMG_HEIGHT * mul - y) * 0.3f, winy - y);
          corner[1] = irr::core::vector2d<irr::s32>(winx2 + (CARD_IMG_HEIGHT * mul - y) * 0.3f, winy - y);
          corner[2] = irr::core::vector2d<irr::s32>(winx, winy);
          corner[3] = irr::core::vector2d<irr::s32>(winx2, winy);
          irr::gui::Draw2DImageQuad(driver, imageManager.GetTexture(showcardcode, true), ResizeFit(0, 0, CARD_IMG_WIDTH, CARD_IMG_HEIGHT), corner);
          showcardp++;
          showcarddif += 9;
          if (showcarddif >= 90) {
            showcarddif = 90;
          }
          if (showcardp == 60) {
            showcardp = 0;
            showcarddif = 0;
          }
          break;
        }
        case 100: {
          if (showcardp < 60) {
            driver->draw2DImage(imageManager.tHand[(showcardcode >> 16) & 0x3], irr::core::vector2di((615 + 44.5) * xScale - 44.5, (showcarddif + 64) * yScale - 64));
            driver->draw2DImage(imageManager.tHand[showcardcode & 0x3], irr::core::vector2di((615 + 44.5) * xScale - 44.5, (540 - showcarddif + 64) * yScale - 64));
            float dy = -0.333333f * showcardp + 10;
            showcardp++;
            if (showcardp < 30) {
              showcarddif += (int)dy;
            }
          }
          else {
            showcard = 0;
          }
          break;
        }
        case 101: {
          const wchar_t *lstr = L"";
          switch (showcardcode) {
            case 1:
              lstr = L"You Win!";
              break;
            case 2:
              lstr = L"You Lose!";
              break;
            case 3:
              lstr = L"Draw Game";
              break;
            case 4:
              lstr = L"Draw Phase";
              break;
            case 5:
              lstr = L"Standby Phase";
              break;
            case 6:
              lstr = L"Main Phase 1";
              break;
            case 7:
              lstr = L"Battle Phase";
              break;
            case 8:
              lstr = L"Main Phase 2";
              break;
            case 9:
              lstr = L"End Phase";
              break;
            case 10:
              lstr = L"Next Players Turn";
              break;
            case 11:
              lstr = L"Duel Start";
              break;
            case 12:
              lstr = L"Duel1 Start";
              break;
            case 13:
              lstr = L"Duel2 Start";
              break;
            case 14:
              lstr = L"Duel3 Start";
              break;
          }
          auto pos = lpcFont->getDimension(lstr);
          if (showcardp < 10) {
            int alpha = (showcardp * 25) << 24;
            DrawShadowText(lpcFont, lstr, ResizePhaseHint(660 - (9 - showcardp) * 40, 290, 960, 370, pos.Width), Resize(-1, -1, 0, 0), alpha | 0xffffff, alpha);
          }
          else if (showcardp < showcarddif) {
            DrawShadowText(lpcFont, lstr, ResizePhaseHint(660, 290, 960, 370, pos.Width), Resize(-1, -1, 0, 0), 0xffffffff);
            if (!dInfo.vic_string.empty() && (showcardcode == 1 || showcardcode == 2)) {
              int w = guiFont->getDimension(dInfo.vic_string.c_str()).Width;
              if (w < 200) {
                w = 200;
              }
              driver->draw2DRectangle(0xa0000000, ResizeWin(640 - w / 2, 320, 690 + w / 2, 340));
              DrawShadowText(guiFont, dInfo.vic_string.c_str(), ResizeWin(640 - w / 2, 320, 690 + w / 2, 340), Resize(-2, -1, 0, 0), 0xffffffff, 0xff000000, true, true, nullptr);
            }
          }
          else if (showcardp < showcarddif + 10) {
            int alpha = ((showcarddif + 10 - showcardp) * 25) << 24;
            DrawShadowText(lpcFont, lstr, ResizePhaseHint(660 + (showcardp - showcarddif) * 40, 290, 960, 370, pos.Width), Resize(-1, -1, 0, 0), alpha | 0xffffff, alpha);
          }
          showcardp++;
          break;
        }
      }
    }
    if (is_attacking) {
      irr::core::matrix4 matk;
      matk.setTranslation(atk_t);
      matk.setRotationRadians(atk_r);
      driver->setTransform(irr::video::ETS_WORLD, matk);
      driver->setMaterial(matManager.mATK);
      driver->drawVertexPrimitiveList(&matManager.vArrow[attack_sv], 12, matManager.iArrow, 10, irr::video::EVT_STANDARD, irr::scene::EPT_TRIANGLE_STRIP);
      attack_sv += 4;
      if (attack_sv > 28) {
        attack_sv = 0;
      }
    }
    bool showChat = true;
    if (hideChat) {
      showChat = false;
      hideChatTimer = 10;
    }
    else if (hideChatTimer > 0) {
      showChat = false;
      hideChatTimer--;
    }
    int chatRectY = 0;
    for (int i = 0; i < 8; ++i) {
      static unsigned int chatColor[] = {0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xff8080ff, 0xffff4040, 0xffff4040, 0xffff4040, 0xff40ff40, 0xff4040ff, 0xff40ffff, 0xffff40ff, 0xffffff40, 0xffffffff, 0xff808080, 0xff404040};
      if (chatTiming[i]) {
        chatTiming[i]--;
        if (!is_building) {
          if (dInfo.isStarted && i >= 5) {
            continue;
          }
          if (!showChat && i > 2) {
            continue;
          }
        }

        int x = wChat->getRelativePosition().UpperLeftCorner.X;
        int y = window_size.Height - 25;
        int maxwidth = 705 * xScale;
        if (is_building) {
          x = 810 * xScale;
          maxwidth = 205 * xScale;
        }

        std::wstring msg = SetStaticText(nullptr, maxwidth, guiFont, chatMsg[i].c_str());
        int w = guiFont->getDimension(msg.c_str()).Width;
        int h = guiFont->getDimension(msg.c_str()).Height + 2;

        irr::core::recti rectloc(x, y - chatRectY - h, x + 2 + w, y - chatRectY);
        irr::core::recti msgloc(x, y - chatRectY - h, x - 4, y - chatRectY);
        irr::core::recti shadowloc = msgloc + irr::core::vector2di(1, 1);

        driver->draw2DRectangle(rectloc, 0xa0000000, 0xa0000000, 0xa0000000, 0xa0000000);
        guiFont->draw(msg.c_str(), msgloc, 0xff000000, false, false);
        guiFont->draw(msg.c_str(), shadowloc, chatColor[chatType[i]], false, false);

        chatRectY += h;
      }
    }
  }

  void Game::DrawBackImage(irr::video::ITexture *texture) {
    if (!texture) {
      return;
    }
    driver->draw2DImage(texture, Resize(0, 0, 1024, 640), irr::core::recti(0, 0, texture->getOriginalSize().Width, texture->getOriginalSize().Height));
  }

  void Game::ShowElement(irr::gui::IGUIElement *win, int autoframe) {
    win->setVisible(true);
  }

  void Game::HideElement(irr::gui::IGUIElement *win, bool set_action) {
    win->setVisible(false);
    if (set_action) {
      DuelClient::SendResponse();
    }
  }

  void Game::PopupElement(irr::gui::IGUIElement *element, int hideframe) {
    if (element == wACMessage) {
      return;
    }
    soundManager.PlayDialogSound(element);
    element->getParent()->bringToFront(element);
    if (!is_building) {
      dField.panel = element;
    }
    if (!hideframe) {
      ShowElement(element);
    }
    else {
      ShowElement(element, hideframe);
    }
    focus_element = element;
  }

  void Game::WaitFrameSignal(int frame) {
    frameSignal.Reset();
    signalFrame = (gameConf.quick_animation && frame >= 12) ? 12 : frame;
    frameSignal.Wait();
  }

  void Game::DrawThumb(code_pointer cp, irr::core::vector2di pos, const LFList *lflist, bool drag) {
    int code = cp->first;
    auto lcode = cp->second.alias;
    if (lcode == 0) {
      lcode = code;
    }
    irr::video::ITexture *img = imageManager.GetTextureThumb(code);
    if (img == nullptr) {
      return; // nullptr->getSize() will cause a crash
    }
    irr::core::dimension2d<irr::u32> size = img->getOriginalSize();
    irr::core::recti dragloc = mainGame->Resize(pos.X, pos.Y, pos.X + CARD_THUMB_WIDTH, pos.Y + CARD_THUMB_HEIGHT);
    irr::core::recti limitloc = mainGame->Resize(pos.X, pos.Y, pos.X + 20, pos.Y + 20);
    irr::core::recti otloc = Resize(pos.X + 7, pos.Y + 50, pos.X + 37, pos.Y + 65);
    if (drag) {
      dragloc = irr::core::recti(pos.X, pos.Y, pos.X + CARD_THUMB_WIDTH * mainGame->xScale, pos.Y + CARD_THUMB_HEIGHT * mainGame->yScale);
      limitloc = irr::core::recti(pos.X, pos.Y, pos.X + 20 * mainGame->xScale, pos.Y + 20 * mainGame->yScale);
      otloc = irr::core::recti(pos.X + 7, pos.Y + 50 * mainGame->yScale, pos.X + 37 * mainGame->xScale, pos.Y + 65 * mainGame->yScale);
    }
    driver->draw2DImage(img, dragloc, irr::core::rect<irr::s32>(0, 0, size.Width, size.Height));
    auto lfit = lflist->content.find(lcode);
    if (lfit != lflist->content.end()) {
      switch (lfit->second) {
        case 0:
          driver->draw2DImage(imageManager.tLim, limitloc, irr::core::recti(0, 0, 64, 64), nullptr, nullptr, true);
          break;
        case 1:
          driver->draw2DImage(imageManager.tLim, limitloc, irr::core::recti(64, 0, 128, 64), nullptr, nullptr, true);
          break;
        case 2:
          driver->draw2DImage(imageManager.tLim, limitloc, irr::core::recti(0, 64, 64, 128), nullptr, nullptr, true);
          break;
      }
    }
    bool showAvail = false;
    bool showNotAvail = false;
    int filter_lm = cbLimit->getSelected();
    bool avail = !((filter_lm == 4 && !(cp->second.ot & AVAIL_OCG) || (filter_lm == 5 && !(cp->second.ot & AVAIL_TCG)) || (filter_lm == 6 && !(cp->second.ot & AVAIL_SC)) || (filter_lm == 7 && !(cp->second.ot & AVAIL_CUSTOM)) || (filter_lm == 8 && (cp->second.ot & AVAIL_OCGTCG) != AVAIL_OCGTCG)));
    if (filter_lm >= 4) {
      showAvail = avail;
      showNotAvail = !avail;
    }
    else if (!(cp->second.ot & gameConf.defaultOT)) {
      showNotAvail = true;
    }
    if (showAvail) {
      if ((cp->second.ot & AVAIL_OCG) && !(cp->second.ot & AVAIL_TCG)) {
        driver->draw2DImage(imageManager.tOT, otloc, irr::core::recti(0, 128, 128, 192), nullptr, nullptr, true);
      }
      else if ((cp->second.ot & AVAIL_TCG) && !(cp->second.ot & AVAIL_OCG)) {
        driver->draw2DImage(imageManager.tOT, otloc, irr::core::recti(0, 192, 128, 256), nullptr, nullptr, true);
      }
    }
    else if (showNotAvail) {
      if (cp->second.ot & AVAIL_OCG) {
        driver->draw2DImage(imageManager.tOT, otloc, irr::core::recti(0, 0, 128, 64), nullptr, nullptr, true);
      }
      else if (cp->second.ot & AVAIL_TCG) {
        driver->draw2DImage(imageManager.tOT, otloc, irr::core::recti(0, 64, 128, 128), nullptr, nullptr, true);
      }
      else if (!avail) {
        driver->draw2DImage(imageManager.tLim, otloc, irr::core::recti(0, 0, 64, 64), nullptr, nullptr, true);
      }
    }
  }

  irr::core::rect<int32_t> Game::draw_gradient_background_size_text(irr::gui::IGUIElement *o1, const char *o2, int64_t o3, const wchar_t *o4) {
    auto gui_xy = luabridge::getGlobal(luabridge::main_thread(this->get_lua()), "xy");
    fast_io::wstring wstr = fast_io::wconcat_fast_io(L" ", fast_io::mnp::os_c_str(dataManager.GetSysString(o3)), fast_io::mnp::os_c_str(o4), L" ");
    o1->setText(wstr.c_str());
    auto wh = guiFont->getDimension(wstr.c_str());
    auto rp = ResizeWin(gui_xy[o2]["x1"], gui_xy[o2]["y1"], gui_xy[o2]["x2"], gui_xy[o2]["y2"]);
    int64_t x1 = rp.UpperLeftCorner.X;
    int64_t y1 = rp.UpperLeftCorner.Y;
    o1->setRelativePosition(irr::core::rect<int32_t>(x1, y1 - wh.Height - 6 * yScale, x1 + wh.Width, y1 - 2 * yScale));
    return rp;
  }

  void Game::DrawDeckBd() {
    auto gui_color = luabridge::getGlobal(luabridge::main_thread(this->get_lua()), "color");
    auto gui_skin = luabridge::getGlobal(luabridge::main_thread(this->get_lua()), "skin");
    auto gui_xy = luabridge::getGlobal(luabridge::main_thread(this->get_lua()), "xy");
    int64_t gui_color_gradient_left_up = gui_color["gradient"]["left_up"];
    int64_t gui_color_gradient_right_up = gui_color["gradient"]["right_up"];
    int64_t gui_color_gradient_left_down = gui_color["gradient"]["left_down"];
    int64_t gui_color_gradient_right_down = gui_color["gradient"]["right_down"];
    wchar_t textBuffer[64];
    this->DrawDeckBd_main_deck();
    if (!deckBuilder.showing_pack) {
      static_text_deck_edit_extra_deck_size->setVisible(true);
      static_text_deck_edit_side_deck_size->setVisible(true);
      this->DrawDeckBd_extra_deck();
      this->DrawDeckBd_side_deck();
    }
    else {
      static_text_deck_edit_extra_deck_size->setVisible(false);
      static_text_deck_edit_side_deck_size->setVisible(false);
    }
    if (is_siding) {
      // side chat background
      driver->draw2DRectangle(Resize(805, 10, 1020, 630), gui_color_gradient_left_up, gui_color_gradient_right_up, gui_color_gradient_left_down, gui_color_gradient_right_down);
      driver->draw2DRectangleOutline(Resize(804, 9, 1020, 630));
    }
    else {
      // search result
      auto rp = draw_gradient_background_size_text(static_text_deck_edit_search_result_size, "gradient_background_search_result", 1333, deckBuilder.result_string);
      driver->draw2DRectangle(rp, gui_color_gradient_left_up, gui_color_gradient_right_up, gui_color_gradient_left_down, gui_color_gradient_right_down);
    }
    int64_t EGDC_BUTTON_TEXT = irr::gui::EGDC_BUTTON_TEXT;
    int64_t gui_color_EGDC_BUTTON_TEXT = gui_skin[EGDC_BUTTON_TEXT];
    for (int i = 0; i < (gui_xy["deck_edit_search_result_show_number"].cast<int64_t>().value() + 2) && i + scrFilter->getPos() < (int)deckBuilder.results.size(); ++i) {
      auto ptr = deckBuilder.results[i + scrFilter->getPos()];
      if (i >= gui_xy["deck_edit_search_result_show_number"].cast<int64_t>().value()) {
        imageManager.GetTextureThumb(ptr->second.code);
        break;
      }
      if (deckBuilder.hovered_pos == 4 && deckBuilder.hovered_seq == i) {
        driver->draw2DRectangle(0x80000000, ResizeWin(gui_xy["gradient_background_search_result"]["x1"], gui_xy["gradient_background_search_result"]["y1"].cast<int64_t>().value() + i * gui_xy["deck_edit_search_result_image"]["height"].cast<int64_t>().value(), gui_xy["gradient_background_search_result"]["x2"], gui_xy["gradient_background_search_result"]["y1"].cast<int64_t>().value() + (i + 1) * gui_xy["deck_edit_search_result_image"]["height"].cast<int64_t>().value()));
      }
      DrawThumb(ptr, irr::core::vector2di(gui_xy["gradient_background_search_result"]["x1"], gui_xy["gradient_background_search_result"]["y1"].cast<int64_t>().value() + i * gui_xy["deck_edit_search_result_image"]["height"].cast<int64_t>().value()), deckBuilder.filterList);
      const auto *availBuffer = get_avail_tag_text(ptr->second.ot);
      auto rp_text_row_1 = ResizeWin(gui_xy["deck_edit_search_result_text_row_1"]["x1"], gui_xy["deck_edit_search_result_text_row_1"]["y1"].cast<int64_t>().value() + i * gui_xy["deck_edit_search_result_image"]["height"].cast<int64_t>().value(), gui_xy["deck_edit_search_result_text_row_1"]["x2"], gui_xy["deck_edit_search_result_text_row_1"]["y2"].cast<int64_t>().value() + i * gui_xy["deck_edit_search_result_image"]["height"].cast<int64_t>().value());
      auto rp_text_row_2 = ResizeWin(gui_xy["deck_edit_search_result_text_row_2"]["x1"], gui_xy["deck_edit_search_result_text_row_2"]["y1"].cast<int64_t>().value() + i * gui_xy["deck_edit_search_result_image"]["height"].cast<int64_t>().value(), gui_xy["deck_edit_search_result_text_row_2"]["x2"], gui_xy["deck_edit_search_result_text_row_2"]["y2"].cast<int64_t>().value() + i * gui_xy["deck_edit_search_result_image"]["height"].cast<int64_t>().value());
      auto rp_text_row_3 = ResizeWin(gui_xy["deck_edit_search_result_text_row_3"]["x1"], gui_xy["deck_edit_search_result_text_row_3"]["y1"].cast<int64_t>().value() + i * gui_xy["deck_edit_search_result_image"]["height"].cast<int64_t>().value(), gui_xy["deck_edit_search_result_text_row_3"]["x2"], gui_xy["deck_edit_search_result_text_row_3"]["y2"].cast<int64_t>().value() + i * gui_xy["deck_edit_search_result_image"]["height"].cast<int64_t>().value());
      if (ptr->second.type & TYPE_MONSTER) {
        myswprintf(textBuffer, L"%ls", dataManager.GetName(ptr->first));
        textFont->draw(textBuffer, rp_text_row_1, gui_color_EGDC_BUTTON_TEXT);
        const wchar_t *form = L"\u2605";
        wchar_t adBuffer[32]{};
        wchar_t scaleBuffer[16]{};
        if (!(ptr->second.type & TYPE_LINK)) {
          if (ptr->second.type & TYPE_XYZ) {
            form = L"\u2606";
          }
          if (ptr->second.attack < 0 && ptr->second.defense < 0) {
            myswprintf(adBuffer, L"?/?");
          }
          else if (ptr->second.attack < 0) {
            myswprintf(adBuffer, L"?/%d", ptr->second.defense);
          }
          else if (ptr->second.defense < 0) {
            myswprintf(adBuffer, L"%d/?", ptr->second.attack);
          }
          else {
            myswprintf(adBuffer, L"%d/%d", ptr->second.attack, ptr->second.defense);
          }
        }
        else {
          form = L"LINK-";
          if (ptr->second.attack < 0) {
            myswprintf(adBuffer, L"?/-");
          }
          else {
            myswprintf(adBuffer, L"%d/-", ptr->second.attack);
          }
        }
        myswprintf(textBuffer, L"%ls/%ls %ls%d", dataManager.FormatAttribute(ptr->second.attribute).c_str(), dataManager.FormatRace(ptr->second.race).c_str(), form, ptr->second.level);
        textFont->draw(textBuffer, rp_text_row_2, gui_color_EGDC_BUTTON_TEXT);
        if (ptr->second.type & TYPE_PENDULUM) {
          myswprintf(scaleBuffer, L" %d/%d", ptr->second.lscale, ptr->second.rscale);
        }
        myswprintf(textBuffer, L"%ls%ls%ls", adBuffer, scaleBuffer, availBuffer);
        textFont->draw(textBuffer, rp_text_row_3, gui_color_EGDC_BUTTON_TEXT);
      }
      else {
        myswprintf(textBuffer, L"%ls", dataManager.GetName(ptr->first));
        textFont->draw(textBuffer, rp_text_row_1, gui_color_EGDC_BUTTON_TEXT);
        myswprintf(textBuffer, L"%ls", dataManager.FormatType(ptr->second.type).c_str());
        textFont->draw(textBuffer, rp_text_row_2, gui_color_EGDC_BUTTON_TEXT);
        myswprintf(textBuffer, L"%ls", availBuffer);
        textFont->draw(textBuffer, rp_text_row_3, gui_color_EGDC_BUTTON_TEXT);
      }
    }
    if (deckBuilder.is_draging) {
      DrawThumb(deckBuilder.draging_pointer, irr::core::vector2di(deckBuilder.dragx - CARD_THUMB_WIDTH / 2 * mainGame->xScale, deckBuilder.dragy - CARD_THUMB_HEIGHT / 2 * mainGame->yScale), deckBuilder.filterList, true);
    }
  }

  void Game::DrawDeckBd_side_deck() {
    auto gui_color = luabridge::getGlobal(luabridge::main_thread(this->get_lua()), "color");
    auto gui_xy = luabridge::getGlobal(luabridge::main_thread(this->get_lua()), "xy");
    auto gui_skin = luabridge::getGlobal(luabridge::main_thread(this->get_lua()), "skin");

    int64_t gui_color_gradient_left_up = gui_color["gradient"]["left_up"];
    int64_t gui_color_gradient_right_up = gui_color["gradient"]["right_up"];
    int64_t gui_color_gradient_left_down = gui_color["gradient"]["left_down"];
    int64_t gui_color_gradient_right_down = gui_color["gradient"]["right_down"];

    int64_t gradient_background_main_deck_width = gui_xy["gradient_background_main_deck"]["width"];
    int64_t gradient_background_main_deck_height = gui_xy["gradient_background_main_deck"]["height"];
    int64_t gradient_background_main_deck_x1_adjust = gui_xy["gradient_background_main_deck"]["x1_adjust"];
    int64_t gradient_background_main_deck_x1_adjust_adjust = gui_xy["gradient_background_main_deck"]["x1_adjust_adjust"];
    int64_t gradient_background_main_deck_x1_adjust_adjust_adjust = gui_xy["gradient_background_main_deck"]["x1_adjust_adjust_adjust"];
    int64_t gradient_background_side_deck_y1_adjust = gui_xy["gradient_background_side_deck"]["y1_adjust"];
    int64_t gradient_background_side_deck_y1_adjust_adjust = gui_xy["gradient_background_side_deck"]["y1_adjust_adjust"];
    int64_t gradient_background_side_deck_y1_adjust_adjust_adjust = gui_xy["gradient_background_side_deck"]["y1_adjust_adjust_adjust"];
    int64_t gradient_background_main_deck_height_adjust = gui_xy["gradient_background_main_deck"]["height_adjust"];

    auto rp = draw_gradient_background_size_text(this->static_text_deck_edit_side_deck_size, "gradient_background_side_deck", 1331, dataManager.GetNumString(deckManager.current_deck.side.size()).c_str());
    driver->draw2DRectangle(rp, gui_color_gradient_left_up, gui_color_gradient_right_up, gui_color_gradient_left_down, gui_color_gradient_right_down);

    int64_t per_row_max_card_capacity = this->get_side_deck_per_row_max_card_capacity();

    auto card_spacing_x = (gui_xy["gradient_background_main_deck"]["width_adjust"].cast<int64_t>().value() * this->main_deck_width_adjust_radio) / (per_row_max_card_capacity - 1);
    auto card_spacing_y = (gradient_background_main_deck_height_adjust * this->main_deck_height_adjust_radio) / (this->main_deck_max_row_capacity - 1);

    for (size_t i = 0; i < deckManager.current_deck.side.size(); ++i) {
      auto vec = irr::core::vector2di(gradient_background_main_deck_x1_adjust + (i % per_row_max_card_capacity) * card_spacing_x, gradient_background_side_deck_y1_adjust + (i / per_row_max_card_capacity) * card_spacing_y);
      DrawThumb(deckManager.current_deck.side[i], vec, deckBuilder.filterList);
      if (deckBuilder.hovered_pos == 3 && deckBuilder.hovered_seq == i) {
        auto x1 = gradient_background_main_deck_x1_adjust_adjust + (i % per_row_max_card_capacity) * card_spacing_x;
        auto y1 = gradient_background_side_deck_y1_adjust_adjust + (i / per_row_max_card_capacity) * card_spacing_y;
        auto x2 = gradient_background_main_deck_x1_adjust_adjust_adjust + (gradient_background_main_deck_width / Game::per_row_min_card_capacity) + (i % per_row_max_card_capacity) * card_spacing_x;
        auto y2 = gradient_background_side_deck_y1_adjust_adjust_adjust + (gradient_background_main_deck_height / Game::main_deck_max_row_capacity) + (i / per_row_max_card_capacity) * card_spacing_y;
        auto r = this->ResizeWin(x1, y1, x2, y2);
        driver->draw2DRectangleOutline(r, gui_skin[static_cast<int64_t>(irr::gui::EGDC_BUTTON_TEXT)].cast<int64_t>().value());
      }
    }
  }

  void Game::DrawDeckBd_extra_deck() {
    auto gui_color = luabridge::getGlobal(luabridge::main_thread(this->get_lua()), "color");
    auto gui_xy = luabridge::getGlobal(luabridge::main_thread(this->get_lua()), "xy");
    auto gui_skin = luabridge::getGlobal(luabridge::main_thread(this->get_lua()), "skin");

    int64_t gui_color_gradient_left_up = gui_color["gradient"]["left_up"];
    int64_t gui_color_gradient_right_up = gui_color["gradient"]["right_up"];
    int64_t gui_color_gradient_left_down = gui_color["gradient"]["left_down"];
    int64_t gui_color_gradient_right_down = gui_color["gradient"]["right_down"];

    int64_t gradient_background_main_deck_width = gui_xy["gradient_background_main_deck"]["width"];
    int64_t gradient_background_main_deck_height = gui_xy["gradient_background_main_deck"]["height"];
    int64_t gradient_background_main_deck_x1_adjust = gui_xy["gradient_background_main_deck"]["x1_adjust"];
    int64_t gradient_background_main_deck_x1_adjust_adjust = gui_xy["gradient_background_main_deck"]["x1_adjust_adjust"];
    int64_t gradient_background_main_deck_x1_adjust_adjust_adjust = gui_xy["gradient_background_main_deck"]["x1_adjust_adjust_adjust"];
    int64_t gradient_background_extra_deck_y1_adjust = gui_xy["gradient_background_extra_deck"]["y1_adjust"];
    int64_t gradient_background_extra_deck_y1_adjust_adjust = gui_xy["gradient_background_extra_deck"]["y1_adjust_adjust"];
    int64_t gradient_background_extra_deck_y1_adjust_adjust_adjust = gui_xy["gradient_background_extra_deck"]["y1_adjust_adjust_adjust"];
    int64_t gradient_background_main_deck_height_adjust = gui_xy["gradient_background_main_deck"]["height_adjust"];

    auto rp = draw_gradient_background_size_text(this->static_text_deck_edit_extra_deck_size, "gradient_background_extra_deck", 1331, dataManager.GetNumString(deckManager.current_deck.extra.size()).c_str());
    driver->draw2DRectangle(rp, gui_color_gradient_left_up, gui_color_gradient_right_up, gui_color_gradient_left_down, gui_color_gradient_right_down);

    int64_t per_row_max_card_capacity = this->get_extra_deck_per_row_max_card_capacity();

    auto card_spacing_x = (gui_xy["gradient_background_main_deck"]["width_adjust"].cast<int64_t>().value() * this->main_deck_width_adjust_radio) / (per_row_max_card_capacity - 1);
    auto card_spacing_y = (gradient_background_main_deck_height_adjust * this->main_deck_height_adjust_radio) / (this->main_deck_max_row_capacity - 1);

    for (size_t i = 0; i < deckManager.current_deck.extra.size(); ++i) {
      auto vec = irr::core::vector2di(gradient_background_main_deck_x1_adjust + (i % per_row_max_card_capacity) * card_spacing_x, gradient_background_extra_deck_y1_adjust + (i / per_row_max_card_capacity) * card_spacing_y);
      DrawThumb(deckManager.current_deck.extra[i], vec, deckBuilder.filterList);
      if (deckBuilder.hovered_pos == 2 && deckBuilder.hovered_seq == i) {
        auto x1 = gradient_background_main_deck_x1_adjust_adjust + (i % per_row_max_card_capacity) * card_spacing_x;
        auto y1 = gradient_background_extra_deck_y1_adjust_adjust + (i / per_row_max_card_capacity) * card_spacing_y;
        auto x2 = gradient_background_main_deck_x1_adjust_adjust_adjust + (gradient_background_main_deck_width / Game::per_row_min_card_capacity) + (i % per_row_max_card_capacity) * card_spacing_x;
        auto y2 = gradient_background_extra_deck_y1_adjust_adjust_adjust + (gradient_background_main_deck_height / Game::main_deck_max_row_capacity) + (i / per_row_max_card_capacity) * card_spacing_y;
        auto r = this->ResizeWin(x1, y1, x2, y2);
        driver->draw2DRectangleOutline(r, gui_skin[static_cast<int64_t>(irr::gui::EGDC_BUTTON_TEXT)].cast<int64_t>().value());
      }
    }
  }

  void Game::DrawDeckBd_main_deck() {
    auto gui_color = luabridge::getGlobal(luabridge::main_thread(this->get_lua()), "color");
    auto gui_skin = luabridge::getGlobal(luabridge::main_thread(this->get_lua()), "skin");
    auto gui_xy = luabridge::getGlobal(luabridge::main_thread(this->get_lua()), "xy");

    int64_t gui_color_gradient_left_up = gui_color["gradient"]["left_up"];
    int64_t gui_color_gradient_right_up = gui_color["gradient"]["right_up"];
    int64_t gui_color_gradient_left_down = gui_color["gradient"]["left_down"];
    int64_t gui_color_gradient_right_down = gui_color["gradient"]["right_down"];

    int64_t gradient_background_main_deck_height = gui_xy["gradient_background_main_deck"]["height"];
    int64_t gradient_background_main_deck_width = gui_xy["gradient_background_main_deck"]["width"];
    int64_t gradient_background_main_deck_x1_adjust = gui_xy["gradient_background_main_deck"]["x1_adjust"];
    int64_t gradient_background_main_deck_x1_adjust_adjust = gui_xy["gradient_background_main_deck"]["x1_adjust_adjust"];
    int64_t gradient_background_main_deck_x1_adjust_adjust_adjust = gui_xy["gradient_background_main_deck"]["x1_adjust_adjust_adjust"];
    int64_t gradient_background_main_deck_y1_adjust = gui_xy["gradient_background_main_deck"]["y1_adjust"];
    int64_t gradient_background_main_deck_y1_adjust_adjust = gui_xy["gradient_background_main_deck"]["y1_adjust_adjust"];
    int64_t gradient_background_main_deck_y1_adjust_adjust_adjust = gui_xy["gradient_background_main_deck"]["y1_adjust_adjust_adjust"];
    int64_t gradient_background_main_deck_height_adjust = gui_xy["gradient_background_main_deck"]["height_adjust"];

    int main_deck_card_count = deckManager.current_deck.main.size();
    auto rp = draw_gradient_background_size_text(static_text_deck_edit_main_deck_size, (deckBuilder.showing_pack ? "gradient_background_main_deck_pack" : "gradient_background_main_deck"), (deckBuilder.showing_pack ? 1477 : 1330), dataManager.GetNumString(main_deck_card_count).c_str());
    driver->draw2DRectangle(rp, gui_color_gradient_left_up, gui_color_gradient_right_up, gui_color_gradient_left_down, gui_color_gradient_right_down);

    int64_t per_row_max_card_capacity = get_main_deck_per_row_max_card_capacity();

    auto card_spacing_x = (gui_xy["gradient_background_main_deck"]["width_adjust"].cast<int64_t>().value() * this->main_deck_width_adjust_radio) / (per_row_max_card_capacity - 1);
    auto card_spacing_y = (gradient_background_main_deck_height_adjust * this->main_deck_height_adjust_radio) / (this->main_deck_max_row_capacity - 1);

    for (int i = 0; i < main_deck_card_count and i < Game::main_deck_pack_max_row_capacity * per_row_max_card_capacity; ++i) {
      auto x_offset = (i % per_row_max_card_capacity) * card_spacing_x;
      auto y_offset = (i / per_row_max_card_capacity) * card_spacing_y;
      auto vec = irr::core::vector2di(gradient_background_main_deck_x1_adjust + x_offset, gradient_background_main_deck_y1_adjust + y_offset);
      DrawThumb(deckManager.current_deck.main[i], vec, deckBuilder.filterList);
      if (deckBuilder.hovered_pos == 1 && deckBuilder.hovered_seq == i) {
        auto x1 = gradient_background_main_deck_x1_adjust_adjust + x_offset;
        auto y1 = gradient_background_main_deck_y1_adjust_adjust + y_offset;
        auto x2 = gradient_background_main_deck_x1_adjust_adjust_adjust + (gradient_background_main_deck_width / Game::per_row_min_card_capacity) + x_offset;
        auto y2 = gradient_background_main_deck_y1_adjust_adjust_adjust + (gradient_background_main_deck_height / Game::main_deck_max_row_capacity) + y_offset;
        auto r = this->ResizeWin(x1, y1, x2, y2);
        this->driver->draw2DRectangleOutline(r, gui_skin[static_cast<int64_t>(irr::gui::EGDC_BUTTON_TEXT)].cast<int64_t>().value());
      }
    }
  }

  int64_t Game::get_side_deck_per_row_max_card_capacity() {
    if (deckManager.current_deck.side.size() > mainGame->per_row_min_card_capacity) {
      return deckManager.current_deck.side.size();
    }
    else {
      return mainGame->per_row_min_card_capacity;
    }
  }

  int64_t Game::get_extra_deck_per_row_max_card_capacity() {
    if (deckManager.current_deck.extra.size() > mainGame->per_row_min_card_capacity) {
      return deckManager.current_deck.extra.size();
    }
    else {
      return mainGame->per_row_min_card_capacity;
    }
  }

  int64_t Game::get_main_deck_per_row_max_card_capacity() {
    if (deckBuilder.showing_pack) {
      if (deckManager.current_deck.main.size() > this->main_deck_pack_min_capacity) {
        return ((deckManager.current_deck.main.size() - (this->main_deck_pack_min_capacity + 1)) / this->main_deck_pack_max_row_capacity) + (this->per_row_min_card_capacity + 1);
      }
    }
    else {
      if (deckManager.current_deck.main.size() > DECK_MIN_SIZE) {
        return (deckManager.current_deck.main.size() - (DECK_MIN_SIZE + 1)) / this->main_deck_max_row_capacity + (this->per_row_min_card_capacity + 1);
      }
    }
    return this->per_row_min_card_capacity;
  }

  const wchar_t *Game::get_avail_tag_text(int64_t o1) {
    if ((o1 & AVAIL_OCGTCG) == AVAIL_OCG) {
      return L" [OCG]";
    }
    else if ((o1 & AVAIL_OCGTCG) == AVAIL_TCG) {
      return L" [TCG]";
    }
    else if ((o1 & AVAIL_CUSTOM) == AVAIL_CUSTOM) {
      return L" [Custom]";
    }
    else {
      return L"";
    }
  }
} // namespace ygo
