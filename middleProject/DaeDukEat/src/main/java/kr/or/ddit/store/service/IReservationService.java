// Source code is decompiled from a .class file using FernFlower decompiler (from Intellij IDEA).
package kr.or.ddit.store.service;

import java.util.List;
import kr.or.ddit.store.vo.ReservationVO;

public interface IReservationService {
   List<ReservationVO> getActiveReservations(String var1) throws Exception;

   List<ReservationVO> getNotifications(String var1) throws Exception;

   boolean cancelReservation(Long var1, String var2) throws Exception;

   ReservationVO getReservationDetail(Long var1) throws Exception;
}
